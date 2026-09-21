import * as React from 'react';
import { cva, type VariantProps } from 'class-variance-authority';
import { cn } from '@/lib/utils';
import { AlertCircle, CheckCircle2, Info, AlertTriangle } from 'lucide-react';

const alertVariants = cva(
  'relative w-full rounded-xl border p-4 text-sm [&>svg~*]:pl-7 [&>svg+div]:translate-y-[-3px] [&>svg]:absolute [&>svg]:left-4 [&>svg]:top-4 [&>svg]:text-foreground',
  {
    variants: {
      variant: {
        default: 'bg-white text-slate-900 border-slate-200',
        info: 'bg-blue-50/70 border-blue-200 text-blue-900 [&>svg]:text-blue-600',
        destructive: 'bg-red-50 border-red-200 text-red-900 [&>svg]:text-red-600',
        success: 'bg-emerald-50 border-emerald-200 text-emerald-900 [&>svg]:text-emerald-600',
        warning: 'bg-amber-50 border-amber-200 text-amber-900 [&>svg]:text-amber-600',
      },
    },
    defaultVariants: {
      variant: 'default',
    },
  }
);

interface AlertProps
  extends React.HTMLAttributes<HTMLDivElement>,
    VariantProps<typeof alertVariants> {
  icon?: boolean;
}

const Alert = React.forwardRef<HTMLDivElement, AlertProps>(
  ({ className, variant = 'default', children, icon = true, id, ...props }, ref) => {
    return (
      <div
        id={id}
        ref={ref}
        role="alert"
        className={cn(alertVariants({ variant }), className)}
        {...props}
      >
        {icon && (
          <>
            {variant === 'destructive' && <AlertCircle className="h-5 w-5" />}
            {variant === 'success' && <CheckCircle2 className="h-5 w-5" />}
            {variant === 'warning' && <AlertTriangle className="h-5 w-5" />}
            {(variant === 'info' || variant === 'default') && <Info className="h-5 w-5" />}
          </>
        )}
        {children}
      </div>
    );
  }
);
Alert.displayName = 'Alert';

const AlertTitle = React.forwardRef<
  HTMLParagraphElement,
  React.HTMLAttributes<HTMLHeadingElement>
>(({ className, id, ...props }, ref) => (
  <h5
    id={id}
    ref={ref}
    className={cn('mb-1 font-semibold leading-none tracking-tight', className)}
    {...props}
  />
));
AlertTitle.displayName = 'AlertTitle';

const AlertDescription = React.forwardRef<
  HTMLParagraphElement,
  React.HTMLAttributes<HTMLParagraphElement>
>(({ className, id, ...props }, ref) => (
  <div
    id={id}
    ref={ref}
    className={cn('text-sm [&_p]:leading-relaxed opacity-90', className)}
    {...props}
  />
));
AlertDescription.displayName = 'AlertDescription';

export { Alert, AlertTitle, AlertDescription };
