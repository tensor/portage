
;;; VM site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(setq vm-toolbar-pixmap-directory "/usr/share/pixmaps/vm")
(setq vm-image-directory "/usr/share/pixmaps/vm")
(autoload 'vm "vm" "Start VM on your primary inbox." t)
(autoload 'vm-other-frame "vm" "Like `vm' but starts in another frame." t)
(autoload 'vm-visit-folder "vm" "Start VM on an arbitrary folder." t)
(autoload 'vm-visit-virtual-folder "vm" "Visit a VM virtual folder." t)
(autoload 'vm-mode "vm" "Run VM major mode on a buffer" t)
(autoload 'vm-mail "vm" "Send a mail message using VM." t)
(autoload 'vm-submit-bug-report "vm" "Send a bug report about VM." t)
