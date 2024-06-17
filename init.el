(setq make-backup-files nil)
(setq create-lockfiles nil)

(use-package emacs
  :ensure nil
  :demand t
  :config
  (setq tab-always-indent 'complete)
  (setq tab-first-completion 'word-or-paren-or-punct)
  (setq-default tab-width 4
                indent-tabs-mode nil))

(use-package text-mode
  :ensure nil
  :mode "\\`\\(README\\|CHANGELOG\\|COPYING\\|LICENSE\\)\\'"
  :hook
  (text-mode . turn-on-auto-fill)
  :config
  (setq-default fill-column 70 )
  (setq sentence-end-double-space nil)
  (setq sentence-end-without-period nil)
  (setq colon-double-space nil)
  (setq use-hard-newlines nil)
  (setq adaptive-fill-mode t))

(setq package-archives
      '(("gnu-elpa" . "https://elpa.gnu.org/packages/")
        ("gnu-elpa-devel" . "https://elpa.gnu.org/devel/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))

;; Highest number gets priority (what is not mentioned has priority 0)
(setq package-archive-priorities
      '(("gnu-elpa" . 3)
        ("melpa" . 2)
        ("nongnu" . 1)))

(use-package magit
  :ensure t
  :bind ("C-c g" . magit-status)
  :hook (git-commit-setup . rrogg-git-commit-setup)
  :init
  (setq magit-define-global-key-bindings nil)
  :config
  (setq git-commit-summary-max-length 50)
  (setq git-commit-style-convention-checks '(non-empty-second-line))
  (setq git-commit-fill-column 70)
  (defun rrogg-git-commit-setup()
    (insert "#1. Capitalize the subject line
#2. Do not end the subject line with a period
#3. Use the present tense imperative mood in the subject line and body
#4. Use the body to explain what and why vs. how
#-----------------------------------------------
#If applied, this commit will …
")))

(use-package savehist
  :ensure nil
  :hook (after-init . savehist-mode)
  :config
  (setq savehist-file (locate-user-emacs-file "savehist"))
  (setq history-length 100)
  (setq history-delete-duplicates t)
  (setq savehist-save-minibuffer-history t)
  (add-to-list 'savehist-additional-variables 'kill-ring))

(use-package modus-themes
  :ensure t
  :demand t
  :bind (("<f5>" . modus-themes-toggle)
         ("C-<f5>" . modus-themes-select))
  :config
  (setq modus-themes-to-toggle '(modus-operandi modus-vivendi))
  (modus-themes-load-theme (cadr modus-themes-to-toggle)))

(use-package nerd-icons
  :ensure t)

(use-package autorevert
  :ensure nil
  :hook (after-init . global-auto-revert-mode)
  :config
  (setq auto-revert-verbose t))

(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))

(use-package time
  :ensure nil
  :hook (after-init . display-time-mode)
  :config
  (setq display-time-format " %a %e %b, %H:%M %Z ")
  (setq display-time-interval 60)
  (setq display-time-default-load-average nil)
  (setq display-time-mail-directory nil)
  (setq display-time-mail-function nil)
  (setq display-time-use-mail-icon nil)
  (setq display-time-mail-string nil)
  (setq display-time-mail-face nil)
  (setq display-time-string-forms
        '((propertize
           (format-time-string display-time-format now)
           'face 'display-time-date-and-time
           'help-echo (format-time-string "%a %b %e, %Y" now))
          " ")))

(use-package time
  :ensure nil
  :commands (world-clock)
  :config
  (setq display-time-world-list t)
  (setq zoneinfo-style-world-list ; M-x shell RET timedatectl list-timezones
        '(("America/Los_Angeles" "Los Angeles")
          ("America/Vancouver" "Vancouver")
          ("Canada/Pacific" "Canada/Pacific")
          ("America/Chicago" "Chicago")
          ("Brazil/Acre" "Rio Branco")
          ("America/New_York" "New York")
          ("Canada/Atlantic" "Canada/Atlantic")
          ("Brazil/East" "Brasília")
          ("UTC" "UTC")
          ("Europe/Lisbon" "Lisbon")
          ("Europe/Brussels" "Brussels")
          ("Europe/Athens" "Athens")
          ("Asia/Riyadh" "Riyadh")
          ("Asia/Tehran" "Tehran")
          ("Asia/Tbilisi" "Tbilisi")
          ("Asia/Yekaterinburg" "Yekaterinburg")
          ("Asia/Kolkata" "Kolkata")
          ("Asia/Singapore" "Singapore")
          ("Asia/Shanghai" "Shanghai")
          ("Asia/Seoul" "Seoul")
          ("Asia/Tokyo" "Tokyo")
          ("Asia/Vladivostok" "Vladivostok")
          ("Australia/Brisbane" "Brisbane")
          ("Australia/Sydney" "Sydney")
          ("Pacific/Auckland" "Auckland")))

  ;; All of the following variables are for Emacs 28
  (setq world-clock-list t)
  (setq world-clock-time-format "%R %z (%Z)	%A %d %B")
  (setq world-clock-buffer-name "*world-clock*")
  (setq world-clock-timer-enable t)
  (setq world-clock-timer-second 60))

(unless (directory-empty-p "/sys/class/power_supply/")
  (use-package battery
    :ensure nil
    :hook (after-init . display-battery-mode)
    :config
    (setq battery-mode-line-format
          (cond
           ((eq battery-status-function #'battery-linux-proc-acpi)
            "⏻%b%p%%,%d°C ")
           (battery-status-function
            "⏻%b%p%% ")))))

(use-package org
  :ensure nil
  :config
  (setq org-confirm-babel-evaluate nil)
  (setq org-src-window-setup 'current-window)
  (setq org-edit-src-persistent-message nil)
  (setq org-src-fontify-natively t)
  (setq org-src-preserve-indentation t)
  (setq org-src-tab-acts-natively t)
  (setq org-edit-src-content-indentation 0)
  (setq org-structure-template-alist
        '(("s" . "src")
          ("e" . "src emacs-lisp")
          ("t" . "src emacs-lisp :tangle FILENAME")
          ("x" . "example")
          ("X" . "export")
          ("q" . "quote"))))
