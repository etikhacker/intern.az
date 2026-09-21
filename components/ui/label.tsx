import * as React from 'react';
import { cn } from '@/lib/utils';

export interface LabelProps extends React.LabelHTMLAttributes<HTMLLabelElement> {}

const Label = React.forwardRef<HTMLLabelElement, LabelProps>(
  ({ className, id, ...props }, ref) => {
    return (
      <label
        id={id}
        ref={ref}
        className={cn(
          'text-xs font-semibold uppercase tracking-wider text-slate-700 block mb-1.5',
          className
        )}
        {...props}
      />
    );
  }
);
Label.displayName = 'Label';

export { Label };
