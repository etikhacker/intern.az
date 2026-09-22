'use client';

import React, { useEffect, useState } from 'react';
import { useAuth } from '@/lib/auth/auth-context';
import { useLanguage } from '@/lib/i18n/language-context';
import {
  getAdminCertificatePayments,
  reviewCertificatePayment,
  getPaymentReceiptSignedUrl,
} from '@/lib/certificates/service';
import { CertificatePayment, PaymentStatus } from '@/types/database';
import { formatDateTime } from '@/lib/utils/date';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import {
  CreditCard,
  CheckCircle2,
  XCircle,
  AlertCircle,
  Clock,
  ExternalLink,
  Search,
  Filter,
  RefreshCw,
  FileText,
  User,
  Briefcase,
  Eye,
  Check,
  X,
  MessageSquare,
} from 'lucide-react';

export default function AdminCertificateOrdersPage() {
  const { profile } = useAuth();
  const { t, language } = useLanguage();

  const [payments, setPayments] = useState<CertificatePayment[]>([]);
  const [loading, setLoading] = useState(true);
  const [statusFilter, setStatusFilter] = useState<string>('all');
  const [searchQuery, setSearchQuery] = useState<string>('');

  // Modals
  const [viewingReceipt, setViewingReceipt] = useState<{ payment: CertificatePayment; signedUrl: string } | null>(null);
  const [rejectingPayment, setRejectingPayment] = useState<CertificatePayment | null>(null);
  const [rejectReason, setRejectReason] = useState('');
  const [actionLoading, setActionLoading] = useState(false);
  const [actionError, setActionError] = useState<string | null>(null);

  const loadData = React.useCallback(async () => {
    try {
      const list = await getAdminCertificatePayments({
        status: statusFilter,
        search: searchQuery,
      });
      setPayments(list);
    } catch (err) {
      console.error('Failed to load payments:', err);
    } finally {
      setLoading(false);
    }
  }, [statusFilter, searchQuery]);

  useEffect(() => {
    let isMounted = true;
    async function fetchData() {
      try {
        const list = await getAdminCertificatePayments({
          status: statusFilter,
          search: searchQuery,
        });
        if (isMounted) {
          setPayments(list);
        }
      } catch (err) {
        console.error('Failed to load payments:', err);
      } finally {
        if (isMounted) {
          setLoading(false);
        }
      }
    }
    fetchData();
    return () => {
      isMounted = false;
    };
  }, [statusFilter, searchQuery]);

  const handleSearchSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    loadData();
  };

  const handleOpenReceipt = async (payment: CertificatePayment) => {
    if (!payment.receipt_path) return;
    try {
      const url = await getPaymentReceiptSignedUrl(payment.receipt_path);
      setViewingReceipt({ payment, signedUrl: url });
    } catch (err) {
      console.error('Failed to load receipt signed url:', err);
    }
  };

  const handleApprove = async (payment: CertificatePayment) => {
    if (!profile?.id) return;
    if (!confirm(`${payment.student?.full_name || 'Tələbə'} üçün ${payment.amount} ${payment.currency} ödənişini təsdiq etmək istəyirsiniz?`)) {
      return;
    }

    setActionLoading(true);
    try {
      const res = await reviewCertificatePayment({
        paymentId: payment.id,
        status: 'approved',
        adminId: profile.id,
        adminNote: 'Ödəniş qəbzi yoxlanıldı və təsdiq edildi.',
      });

      if (res.success) {
        await loadData();
      } else {
        alert(res.error || 'Təsdiqlənərkən xəta baş verdi');
      }
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : 'Xəta baş verdi';
      alert(msg);
    } finally {
      setActionLoading(false);
    }
  };

  const handleRejectSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!profile?.id || !rejectingPayment) return;
    if (!rejectReason.trim()) {
      setActionError('Rədd etmə səbəbini mütləq qeyd edin.');
      return;
    }

    setActionLoading(true);
    setActionError(null);

    try {
      const res = await reviewCertificatePayment({
        paymentId: rejectingPayment.id,
        status: 'rejected',
        adminId: profile.id,
        adminNote: rejectReason.trim(),
      });

      if (res.success) {
        setRejectingPayment(null);
        setRejectReason('');
        await loadData();
      } else {
        setActionError(res.error || 'Rədd edilərkən xəta baş verdi');
      }
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : 'Xəta baş verdi';
      setActionError(msg);
    } finally {
      setActionLoading(false);
    }
  };

  const pendingCount = payments.filter((p) => p.status === 'pending').length;

  return (
    <div className="space-y-6 max-w-7xl">
      {/* Header */}
      <div className="pb-4 border-b border-slate-800 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <div className="flex items-center gap-2">
            <h1 className="text-2xl font-bold text-white tracking-tight">
              Sertifikat Sifarişləri
            </h1>
            {pendingCount > 0 && (
              <Badge variant="warning" className="bg-amber-400 text-slate-950 font-bold text-[10px]">
                {pendingCount} yeni gözləyən
              </Badge>
            )}
          </div>
          <p className="text-xs text-slate-400 mt-1">
            Tələbələr tərəfindən göndərilmiş ödəniş qəbzlərini yoxlayın, təsdiq və ya rədd edin.
          </p>
        </div>

        <Button
          size="sm"
          variant="outline"
          onClick={loadData}
          disabled={loading}
          className="text-xs border-slate-700 text-slate-300 hover:text-white hover:bg-slate-800"
        >
          <RefreshCw className={`w-3.5 h-3.5 mr-1.5 ${loading ? 'animate-spin' : ''}`} />
          <span>Yenilə</span>
        </Button>
      </div>

      {/* Filter Tabs & Search Bar */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        {/* Status Tabs */}
        <div className="flex items-center gap-1.5 p-1 bg-slate-900 border border-slate-800 rounded-xl overflow-x-auto">
          {[
            { id: 'all', label: 'Bütün Sifarişlər' },
            { id: 'pending', label: 'Gözləmədə' },
            { id: 'approved', label: 'Təsdiqlənmiş' },
            { id: 'rejected', label: 'Rədd edilmiş' },
          ].map((tab) => (
            <button
              key={tab.id}
              onClick={() => setStatusFilter(tab.id)}
              className={`px-3 py-1.5 rounded-lg text-xs font-medium whitespace-nowrap transition-colors ${
                statusFilter === tab.id
                  ? 'bg-amber-400 text-slate-950 font-bold shadow-2xs'
                  : 'text-slate-400 hover:text-white hover:bg-slate-800'
              }`}
            >
              {tab.label}
            </button>
          ))}
        </div>

        {/* Search */}
        <form onSubmit={handleSearchSubmit} className="flex items-center gap-2 max-w-sm w-full">
          <div className="relative flex-1">
            <Search className="w-3.5 h-3.5 text-slate-500 absolute left-3 top-2.5" />
            <input
              type="text"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder="Tələbə adı və ya proqram..."
              className="w-full pl-8 pr-3 py-1.5 rounded-lg bg-slate-900 border border-slate-800 text-white text-xs placeholder:text-slate-500 focus:border-amber-400 focus:outline-hidden"
            />
          </div>
          <Button type="submit" size="sm" className="bg-slate-800 hover:bg-slate-700 text-slate-200 text-xs h-8">
            Axtar
          </Button>
        </form>
      </div>

      {/* Orders List / Table */}
      {loading ? (
        <div className="flex flex-col items-center justify-center min-h-[300px] space-y-3">
          <RefreshCw className="w-8 h-8 text-amber-400 animate-spin" />
          <p className="text-xs text-slate-400">Sifarişlər yüklənir...</p>
        </div>
      ) : payments.length === 0 ? (
        <Card className="border-slate-800 bg-slate-900/60">
          <CardContent className="p-12 text-center text-xs text-slate-400 space-y-2">
            <CreditCard className="w-10 h-10 text-slate-600 mx-auto" />
            <p className="font-semibold text-slate-300">Heç bir ödəniş sifarişi tapılmadı.</p>
            <p className="text-slate-500">Filtrləri dəyişdirərək yenidən yoxlayın.</p>
          </CardContent>
        </Card>
      ) : (
        <div className="space-y-3">
          {payments.map((p) => {
            const isPending = p.status === 'pending';
            const isApproved = p.status === 'approved';
            const isRejected = p.status === 'rejected';

            return (
              <Card
                key={p.id}
                className={`border transition-all ${
                  isPending
                    ? 'border-amber-500/40 bg-slate-900 shadow-xs'
                    : 'border-slate-800 bg-slate-900/60'
                }`}
              >
                <CardContent className="p-4 sm:p-5 flex flex-col lg:flex-row lg:items-center justify-between gap-4">
                  {/* Left: Student & Internship Info */}
                  <div className="space-y-2 min-w-0 flex-1">
                    <div className="flex items-center gap-2.5 flex-wrap">
                      <span className="text-sm font-bold text-white">
                        {p.student?.full_name || 'Tələbə'}
                      </span>
                      <span className="text-xs text-slate-400">
                        ({p.student?.email || 'email qeyd olunmayıb'})
                      </span>
                      {isPending && (
                        <Badge variant="warning" className="text-[10px]">
                          Gözləmədə
                        </Badge>
                      )}
                      {isApproved && (
                        <Badge variant="default" className="bg-emerald-500/20 text-emerald-300 border-emerald-500/30 text-[10px]">
                          Təsdiqləndi
                        </Badge>
                      )}
                      {isRejected && (
                        <Badge variant="destructive" className="text-[10px]">
                          Rədd edildi
                        </Badge>
                      )}
                    </div>

                    <div className="flex items-center gap-4 text-xs text-slate-400 flex-wrap">
                      <span className="flex items-center gap-1.5 text-slate-300 font-medium">
                        <Briefcase className="w-3.5 h-3.5 text-amber-400" />
                        {p.internship?.title || 'Təcrübə Proqramı'}
                      </span>
                      <span className="text-slate-500">•</span>
                      <span>
                        Tarix: {formatDateTime(p.created_at)}
                      </span>
                    </div>

                    {/* Admin Note if Rejected */}
                    {p.admin_note && (
                      <div className="p-2.5 rounded-lg bg-slate-950 border border-slate-800 text-xs text-slate-300 flex items-start gap-2">
                        <MessageSquare className="w-3.5 h-3.5 text-amber-400 shrink-0 mt-0.5" />
                        <span className="text-[11px] leading-relaxed">
                          <strong className="text-slate-400">İnzibatçı rəyi:</strong> {p.admin_note}
                        </span>
                      </div>
                    )}
                  </div>

                  {/* Middle: Amount & Receipt Preview Button */}
                  <div className="flex items-center gap-4 shrink-0">
                    <div className="text-right">
                      <span className="text-[10px] uppercase font-bold text-slate-500 block">Məbləğ</span>
                      <span className="text-base font-black font-mono text-amber-400">
                        {p.amount} {p.currency}
                      </span>
                    </div>

                    <Button
                      size="sm"
                      variant="outline"
                      onClick={() => handleOpenReceipt(p)}
                      className="h-9 px-3 text-xs border-slate-700 bg-slate-800 text-slate-200 hover:text-white hover:bg-slate-700 gap-1.5"
                    >
                      <Eye className="w-3.5 h-3.5 text-amber-400" />
                      <span>Qəbzə bax</span>
                    </Button>
                  </div>

                  {/* Right: Actions */}
                  <div className="flex items-center gap-2 shrink-0 pt-2 lg:pt-0 border-t lg:border-t-0 border-slate-800">
                    {isPending ? (
                      <>
                        <Button
                          size="sm"
                          onClick={() => handleApprove(p)}
                          disabled={actionLoading}
                          className="h-9 px-3 text-xs bg-emerald-600 hover:bg-emerald-500 text-white font-semibold gap-1.5 shadow-2xs"
                        >
                          <Check className="w-3.5 h-3.5" />
                          <span>Təsdiqlə</span>
                        </Button>
                        <Button
                          size="sm"
                          variant="destructive"
                          onClick={() => {
                            setRejectingPayment(p);
                            setRejectReason('');
                            setActionError(null);
                          }}
                          disabled={actionLoading}
                          className="h-9 px-3 text-xs gap-1.5"
                        >
                          <X className="w-3.5 h-3.5" />
                          <span>Rədd et</span>
                        </Button>
                      </>
                    ) : isApproved ? (
                      <span className="text-xs text-emerald-400 font-medium flex items-center gap-1">
                        <CheckCircle2 className="w-4 h-4" />
                        <span>Təsdiqlənib</span>
                      </span>
                    ) : (
                      <span className="text-xs text-red-400 font-medium flex items-center gap-1">
                        <XCircle className="w-4 h-4" />
                        <span>Rədd edilib</span>
                      </span>
                    )}
                  </div>
                </CardContent>
              </Card>
            );
          })}
        </div>
      )}

      {/* Receipt Viewer Modal */}
      {viewingReceipt && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-950/85 backdrop-blur-2xs">
          <div className="relative w-full max-w-2xl bg-slate-900 border border-slate-800 rounded-2xl shadow-2xl overflow-hidden animate-in fade-in zoom-in-95 duration-150">
            <div className="p-4 border-b border-slate-800 flex items-center justify-between bg-slate-950">
              <div>
                <h3 className="text-sm font-bold text-white flex items-center gap-2">
                  <CreditCard className="w-4 h-4 text-amber-400" />
                  <span>Ödəniş Qəbzi İcmalı</span>
                </h3>
                <p className="text-xs text-slate-400 mt-0.5">
                  {viewingReceipt.payment.student?.full_name} • {viewingReceipt.payment.amount} {viewingReceipt.payment.currency}
                </p>
              </div>
              <button
                onClick={() => setViewingReceipt(null)}
                className="p-1.5 text-slate-400 hover:text-white rounded-lg hover:bg-slate-800 transition-colors"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            <div className="p-4 max-h-[70vh] overflow-y-auto flex items-center justify-center bg-slate-950/50">
              {viewingReceipt.signedUrl.endsWith('.pdf') ? (
                <div className="text-center py-8 space-y-3">
                  <FileText className="w-16 h-16 text-amber-400 mx-auto" />
                  <p className="text-xs text-slate-300">PDF Qəbz Sənədi</p>
                  <a
                    href={viewingReceipt.signedUrl}
                    target="_blank"
                    rel="noopener noreferrer"
                  >
                    <Button size="sm" className="bg-amber-400 text-slate-950 font-bold text-xs gap-1.5">
                      <ExternalLink className="w-3.5 h-3.5" />
                      <span>PDF-i Yeni Tabda Aç</span>
                    </Button>
                  </a>
                </div>
              ) : (
                <img
                  src={viewingReceipt.signedUrl}
                  alt="Receipt"
                  className="max-h-[60vh] max-w-full object-contain rounded-lg border border-slate-800"
                />
              )}
            </div>

            <div className="p-3 border-t border-slate-800 bg-slate-950 flex justify-between items-center text-xs">
              <span className="text-slate-400 font-mono">
                {viewingReceipt.payment.receipt_path}
              </span>
              <a
                href={viewingReceipt.signedUrl}
                target="_blank"
                rel="noopener noreferrer"
                className="text-amber-400 hover:underline flex items-center gap-1"
              >
                <span>Tam ölçüdə aç</span>
                <ExternalLink className="w-3 h-3" />
              </a>
            </div>
          </div>
        </div>
      )}

      {/* Reject Reason Modal */}
      {rejectingPayment && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-950/85 backdrop-blur-2xs">
          <div className="relative w-full max-w-md bg-slate-900 border border-slate-800 rounded-2xl shadow-2xl overflow-hidden animate-in fade-in zoom-in-95 duration-150">
            <div className="p-4 border-b border-slate-800 flex items-center justify-between bg-slate-950">
              <h3 className="text-sm font-bold text-red-400 flex items-center gap-2">
                <XCircle className="w-4 h-4 text-red-500" />
                <span>Ödənişi Rədd Et</span>
              </h3>
              <button
                onClick={() => setRejectingPayment(null)}
                className="p-1.5 text-slate-400 hover:text-white rounded-lg hover:bg-slate-800 transition-colors"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            <form onSubmit={handleRejectSubmit} className="p-5 space-y-4 text-xs">
              <p className="text-slate-300">
                <strong>{rejectingPayment.student?.full_name}</strong> adlı tələbənin ödənişini rədd etmək üçün səbəbi qeyd edin. Bu qeyd tələbənin dashboard-unda görünəcək.
              </p>

              <div className="space-y-1.5">
                <label className="text-slate-300 font-semibold block">
                  Rədd etmə səbəbi / Qeyd *
                </label>
                <textarea
                  value={rejectReason}
                  onChange={(e) => setRejectReason(e.target.value)}
                  rows={4}
                  placeholder="Məsələn: Qəbz oxunaqlı deyil / Ödəniş məbləği 25 AZN olmalıdır / Qəbz fərqli hesaba aiddir..."
                  required
                  className="w-full px-3 py-2 rounded-lg bg-slate-950 border border-slate-700 text-white placeholder:text-slate-600 focus:border-red-500 focus:outline-hidden"
                />
              </div>

              {actionError && (
                <div className="p-3 rounded-lg bg-red-950/40 border border-red-800 text-red-300 flex items-center gap-2">
                  <AlertCircle className="w-4 h-4 shrink-0 text-red-400" />
                  <span>{actionError}</span>
                </div>
              )}

              <div className="pt-3 border-t border-slate-800 flex items-center justify-end gap-2.5">
                <Button
                  type="button"
                  variant="outline"
                  onClick={() => setRejectingPayment(null)}
                  className="text-xs border-slate-700 text-slate-300 hover:text-white hover:bg-slate-800"
                >
                  Bağla
                </Button>
                <Button
                  type="submit"
                  disabled={actionLoading || !rejectReason.trim()}
                  className="text-xs bg-red-600 hover:bg-red-500 text-white font-bold"
                >
                  {actionLoading ? 'İcra edilir...' : 'Rədd etməni təsdiqlə'}
                </Button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
