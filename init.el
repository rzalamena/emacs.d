;; Initialize package handling
(package-initialize)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))

(or (file-exists-p package-user-dir) (package-refresh-contents))

;; Install required packages
(setq package-list '(
		     alchemist
		     base16-theme
		     company-jedi
		     company-quickhelp
		     ido-vertical-mode
		     ))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


;; UI
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

(require 'base16-default-dark-theme)


;; Editing
(electric-pair-mode t)
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq require-final-newline t)

;; Elixir
(require 'alchemist)

;; Python
(require 'company-jedi)
(add-to-list 'company-backends 'company-jedi)

;; Make auto-complete global
(global-company-mode)

(require 'company-quickhelp)
(company-quickhelp-mode)


;; Browsing
(require 'ido)
(ido-mode t)

(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-case-fold t
      ido-create-new-buffer 'always
      ido-use-filename-at-point nil
      ido-everywhere t
      )

(require 'ido-vertical-mode)
(ido-vertical-mode t)


;; Custom settings generated by emacs configuration tool