;; Package handling
;;
;; List used packages and install them if they are missing so we don't get
;; start-up errors.

(package-initialize)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))

(setq package-list '(
		     auto-complete
		     ido-vertical-mode
		     lua-mode
		     markdown-mode
		     tao-theme
		     ))

(or (file-exists-p package-user-dir) (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; Appearance and theme
(require 'tao-yin-theme)

(display-time-mode t)

(column-number-mode t)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Show annoying whitespaces
(require 'whitespace)
(setq whitespace-style '(face trailing lines-tail empty
			 space-after-tab::tab space-after-tab::space
			 space-after-tab space-before-tab::tab
			 space-before-tab::space space-before-tab))
(global-whitespace-mode t)

;; Editing
(require 'auto-complete)
(ac-config-default)

;; I hate spaces
(setq-default indent-tabs-mode t)

;; Allows me to ctrl+s and then ctrl+w
(global-subword-mode t)

;; Shorten questions of 'yes or no' to 'y or p'
(defalias 'yes-or-no-p 'y-or-n-p)

;; Automatic complete parentesis / quotes etc...
(electric-pair-mode t)

;; save last open buffers n' stuff
(desktop-save-mode t)

;; I hate auto-save
(setq auto-save-default nil)

;; I hate backups
(setq make-backup-files nil)

;; Newlines at the end so gcc will shutup
(setq require-final-newline t)

;; Browsing
(require 'ido)
(ido-mode t)

(define-key global-map (kbd "<f8>") 'rgrep)

(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-case-fold t
      ido-create-new-buffer 'always
      ido-use-filename-at-point nil
      ido-everywhere t
      )

(require 'ido-vertical-mode)
(ido-vertical-mode t)

;; C stuff
(defun new-c-lineup-arglist (langelem)
  (save-excursion
    (goto-char (cdr langelem))
    (setq syntax (car (car (c-guess-basic-syntax))))
    (while (or (eq syntax 'arglist-intro)
	       (or (eq syntax 'arglist-cont)
		   (eq syntax 'arglist-cont-nonempty)))
      (forward-line -1)
      (setq syntax (car (car (c-guess-basic-syntax)))))
    (beginning-of-line)
    (re-search-forward "[^ \t]" (c-point 'eol))
    (goto-char (+ (match-beginning 0) 4))
    (vector (current-column))))

(c-add-style "openbsd"
	     '("bsd"
	       (c-ignore-auto-fill . '(string))
	       (c-subword-mode . 0)
	       (c-basic-offset . 8)
	       (c-label-minimum-indentation . 0)
	       (c-offsets-alist .
				((arglist-intro . new-c-lineup-arglist)
				 (arglist-cont . new-c-lineup-arglist)
				 (arglist-cont-nonempty . new-c-lineup-arglist)
				 (arglist-close . 0)
				 (substatement-open . 0)
				 (statement-cont . *)
				 (case-label . 0)
				 (knr-argdecl . *)))
	       (fill-column . 80)
	       (tab-width . 8)
	       (indent-tabs-mode . t)))

(setq c-default-style "openbsd")
(setq c-set-style "openbsd")

(setq-default fill-column 80)

(set-frame-font "-xos4-Terminus-bold-normal-normal-*-22-*-*-*-c-110-iso10646-1")

;; Automatic generated stuff

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (markdown-mode lua-mode ido-vertical-mode tao-theme auto-complete)))
 '(perl-indent-continued-arguments 4)
 '(perl-indent-level 8))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-empty ((t (:background "dark red"))))
 '(whitespace-line ((t (:background "dark red" :foreground "#D9D9D9"))))
 '(whitespace-space-after-tab ((t (:background "#F6F6F6" :foreground "#D9D9D9"))))
 '(whitespace-space-before-tab ((t (:background "#E8E8E8" :foreground "#E8E8E8")))))
