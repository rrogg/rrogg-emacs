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
  (setq modus-themes-mixed-fonts t)
  (modus-themes-load-theme (cadr modus-themes-to-toggle)))

(use-package fontaine
  :ensure t
  :if (display-graphic-p)
  :hook
  ((after-init . fontaine-mode)
   (after-init . (lambda ()
                   (fontaine-set-preset (or (fontaine-restore-latest-preset) 'regular)))))
  :bind ("C-c f" . fontaine-set-preset)
  :config
  (setq fontaine-presets
        '((small
           :default-family "Hack"
           :default-height 100
           :variable-pitch-family "Hack")
          (regular)
          (medium
           :default-weight semilight
           :default-height 130
           :bold-weight extrabold)
          (large
           :inherit medium
           :default-height 150)
          (t
           :default-family "Hack"
           :default-weight regular
           :default-slant normal
           :default-height 120

           :fixed-pitch-family "Hack"
           :fixed-pitch-weight nil
           :fixed-pitch-slant nil
           :fixed-pitch-height 1.0

           :variable-pitch-family "Inter"
           :variable-pitch-weight nil
           :variable-pitch-slant nil
           :variable-pitch-height 1.0))))

(use-package face-remap
  :ensure nil
  :hook (text-mode . variable-pitch-mode)
  :bind
  (("C-x C-=" . global-text-scale-adjust)
   ("C-x C-+" . global-text-scale-adjust)
   ("C-x C-0" . global-text-scale-adjust)))

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

(use-package vertico
  :ensure t
  :hook (after-init . vertico-mode)
  :config
  (setq vertico-scroll-margin 0)
  (setq vertico-count 5)
  (setq vertico-resize t)
  (setq vertico-cycle t))

(use-package marginalia
  :ensure t
  :defer 1
  :config
  (setq marginalia-max-relative-age 0)
  (marginalia-mode 1))

(use-package emacs
  :ensure nil
  :config
  (setq mode-line-compact nil)
  (setq mode-line-right-align-edge 'right-margin)
  (setq-default mode-line-format
                '("%e"
                  prot-modeline-buffer-status
                  prot-modeline-window-dedicated-status
                  prot-modeline-input-method
                  "  "
                  rrogg-modeline-buffer-identification
                  "  "
                  rrogg-modeline-major-mode
                  prot-modeline-process
                  "  "
                  prot-modeline-vc-branch
                  "  "
                  mode-line-format-right-align
                  "  "
                  prot-modeline-misc-info)))

;;; Mode line faces

(defgroup prot-modeline nil
  "Custom modeline that is stylistically close to the default."
  :group 'mode-line)

(defgroup prot-modeline-faces nil
  "Faces for my custom modeline."
  :group 'prot-modeline)

(defface prot-modeline-indicator-button nil
  "Generic face used for indicators that have a background.
Modify this face to, for example, add a :box attribute to all
relevant indicators (combines nicely with my `spacious-padding'
package).")

(defface prot-modeline-indicator-red-bg
  '((default :inherit (bold prot-modeline-indicator-button))
    (((class color) (min-colors 88) (background light))
     :background "#aa1111" :foreground "white")
    (((class color) (min-colors 88) (background dark))
     :background "#ff9090" :foreground "black")
    (t :background "red" :foreground "black"))
  "Face for modeline indicators with a background."
  :group 'prot-modeline-faces)

(defface prot-modeline-indicator-gray-bg
  '((default :inherit (bold prot-modeline-indicator-button))
    (((class color) (min-colors 88) (background light))
     :background "#808080" :foreground "white")
    (((class color) (min-colors 88) (background dark))
     :background "#a0a0a0" :foreground "black")
    (t :inverse-video t))
  "Face for modeline indicatovrs with a background."
  :group 'prot-modeline-faces)

(defface prot-modeline-indicator-green-bg
  '((default :inherit (bold prot-modeline-indicator-button))
    (((class color) (min-colors 88) (background light))
     :background "#207b20" :foreground "white")
    (((class color) (min-colors 88) (background dark))
     :background "#77d077" :foreground "black")
    (t :background "green" :foreground "black"))
  "Face for modeline indicators with a background."
  :group 'prot-modeline-faces)

;;; Buffer status

(defvar-local prot-modeline-buffer-status
    '(:eval
      (when (file-remote-p default-directory)
        (propertize " @ "
                    'face 'prot-modeline-indicator-red-bg
                    'mouse-face 'mode-line-highlight)))
  "Mode line construct for showing remote file name.")

;;; Dedicated window

(defvar-local prot-modeline-window-dedicated-status
    '(:eval
      (when (window-dedicated-p)
        (propertize " = "
                    'face 'prot-modeline-indicator-gray-bg
                    'mouse-face 'mode-line-highlight)))
  "Mode line construct for dedicated window indicator.")

;;; Input method

(defvar-local prot-modeline-input-method
    '(:eval
      (when current-input-method-title
        (propertize (format " %s " current-input-method-title)
                    'face 'prot-modeline-indicator-green-bg
                    'mouse-face 'mode-line-highlight)))
  "Mode line construct to report the multilingual environment.")

;;; Buffer name

(defun prot-modeline-buffer-identification-face ()
  "Return appropriate face or face list for `prot-modeline-buffer-identification'."
  (let ((file (buffer-file-name)))
    (cond
     ((and (mode-line-window-selected-p)
           file
           (buffer-modified-p))
      '(italic mode-line-buffer-id))
     ((and file
           (buffer-modified-p))
      'italic)
     ((mode-line-window-selected-p)
      'mode-line-buffer-id))))

(defun rrogg-modeline-buffer-name ()
  "Return buffer name, with read-only indicator if relevant."
  (let ((name (buffer-name)))
    (if buffer-read-only
        (format "%s %s" (char-to-string #xE0A2) name)
      name)))

(defun prot-modeline-buffer-name-help-echo ()
  "Return `help-echo' value for `rrogg-modeline-buffer-identification'."
  (concat
   (propertize (buffer-name) 'face 'mode-line-buffer-id)
   "\n"
   (propertize
    (or (buffer-file-name)
        (format "No underlying file.\nDirectory is: %s" default-directory))
    'face 'font-lock-doc-face)))

(defvar-local rrogg-modeline-buffer-identification
    '(:eval
      (propertize (rrogg-modeline-buffer-name)
                  'face (prot-modeline-buffer-identification-face)
                  'mouse-face 'mode-line-highlight
                  'help-echo (prot-modeline-buffer-name-help-echo)))
  "Mode line construct for identifying the buffer being displayed.
Propertize the current buffer with the `mode-line-buffer-id'
face.  Let other buffers have no face.")

;;; Major mode

(defun prot-modeline-major-mode-indicator ()
  "Return appropriate propertized mode line indicator for the major mode."
  (let ((indicator (cond
                    ((derived-mode-p 'text-mode) "§")
                    ((derived-mode-p 'prog-mode) "λ")
                    ((derived-mode-p 'comint-mode) ">_")
                    (t "◦"))))
    (propertize indicator 'face 'shadow)))

(defun prot-modeline-major-mode-name ()
  "Return capitalized `major-mode' without the -mode suffix."
  (capitalize (string-replace "-mode" "" (symbol-name major-mode))))

(defun prot-modeline-major-mode-help-echo ()
  "Return `help-echo' value for `prot-modeline-major-mode'."
  (if-let ((parent (get major-mode 'derived-mode-parent)))
      (format "Symbol: `%s'.  Derived from: `%s'" major-mode parent)
    (format "Symbol: `%s'." major-mode)))

(defvar-local rrogg-modeline-major-mode
     '(:eval
       (concat
        (prot-modeline-major-mode-indicator)
        " "
        (propertize (prot-modeline-major-mode-name)
         'mouse-face 'mode-line-highlight
         'help-echo (prot-modeline-major-mode-help-echo))))
  "Mode line construct for displaying major modes.")

;;; Processes

(defvar-local prot-modeline-process
    (list '("" mode-line-process))
  "Mode line construct for the running process indicator.")


;;; vc branch

(declare-function vc-git--symbolic-ref "vc-git" (file))

(defun prot-modeline--vc-branch-name (file backend)
  "Return capitalized VC branch name for FILE with BACKEND."
  (when-let ((rev (vc-working-revision file backend))
             (branch (or (vc-git--symbolic-ref file)
                         (substring rev 0 7))))
    (capitalize branch)))

(declare-function vc-git-working-revision "vc-git" (file))

(defvar prot-modeline-vc-map
  (let ((map (make-sparse-keymap)))
    (define-key map [mode-line down-mouse-1] 'vc-diff)
    (define-key map [mode-line down-mouse-3] 'vc-root-diff)
    map)
  "Keymap to display on VC indicator.")

(defun prot-modeline--vc-help-echo (file)
  "Return `help-echo' message for FILE tracked by VC."
  (format "Revision: %s\nmouse-1: `vc-diff'\nmouse-3: `vc-root-diff'"
          (vc-working-revision file)))

(defun prot-modeline--vc-text (file branch &optional face)
  "Prepare text for Git controlled FILE, given BRANCH.
With optional FACE, use it to propertize the BRANCH."
  (concat
   (propertize (char-to-string #xE0A0) 'face 'shadow)
   " "
   (propertize branch
               'face face
               'mouse-face 'mode-line-highlight
               'help-echo (prot-modeline--vc-help-echo file)
               'local-map prot-modeline-vc-map)))

(defun prot-modeline--vc-details (file branch &optional face)
  "Return Git BRANCH details for FILE."
  (prot-modeline--vc-text file branch face))

(defvar prot-modeline--vc-faces
  '((added . vc-locally-added-state)
    (edited . vc-edited-state)
    (removed . vc-removed-state)
    (missing . vc-missing-state)
    (conflict . vc-conflict-state)
    (locked . vc-locked-state)
    (up-to-date . vc-up-to-date-state))
  "VC state faces.")

(defun prot-modeline--vc-get-face (key)
  "Get face from KEY in `prot-modeline--vc-faces'."
   (alist-get key prot-modeline--vc-faces 'up-to-date))

(defun prot-modeline--vc-face (file backend)
  "Return VC state face for FILE with BACKEND."
  (prot-modeline--vc-get-face (vc-state file backend)))

(defvar-local prot-modeline-vc-branch
    '(:eval
      (when-let* (((mode-line-window-selected-p))
                  (file (buffer-file-name))
                  (backend (vc-backend file))
                  (branch (prot-modeline--vc-branch-name file backend))
                  (face (prot-modeline--vc-face file backend)))
        (prot-modeline--vc-details file branch face)))
  "Mode line construct to return propertized VC branch.")

;;; Misc info

(defvar-local prot-modeline-misc-info
    '(:eval
      (when (mode-line-window-selected-p)
        mode-line-misc-info))
  "Mode line construct displaying `mode-line-misc-info'.
Specific to the current window's mode line.")


;;; Enable risky variables

(dolist (construct '(prot-modeline-buffer-status
                     prot-modeline-window-dedicated-status
                     prot-modeline-input-method
                     rrogg-modeline-buffer-identification
                     rrogg-modeline-major-mode
                     prot-modeline-process
                     prot-modeline-vc-branch
                     prot-modeline-misc-info))
  (put construct 'risky-local-variable t))

(use-package ediff
  :ensure nil
  :commands (ediff-buffers ediff-files ediff-buffers3 ediff-files3)
  :init
  (setq ediff-split-window-function 'split-window-horizontally)
  (setq ediff-window-setup-function 'ediff-setup-windows-plain))

(use-package calendar
  :ensure nil
  :commands (calendar)
  :config
  (setq calendar-mark-diary-entries-flag nil)
  (setq calendar-mark-holidays-flag t)
  (setq calendar-mode-line-format nil)
  (setq calendar-time-display-form
        '( 24-hours ":" minutes
           (when time-zone (format "(%s)" time-zone))))
  (setq calendar-week-start-day 1)      ; Monday
  (setq calendar-date-style 'iso)
  (setq calendar-time-zone-style 'numeric) ; Emacs 28.1

  (require 'cal-dst)
  (setq calendar-standard-time-zone-name "+0200")
  (setq calendar-daylight-time-zone-name "+0100"))

(use-package holidays
  :ensure nil
  :config
  (setq calendar-holidays
        '((holiday-fixed 1 1 "Neujahr")
          (holiday-fixed 5 1 "Tag der Arbeit")
          (holiday-fixed 10 3 "Tag der Deutschen Einheit")
          (holiday-fixed 12 25 "1. Weihnachtstag")
          (holiday-fixed 12 26 "2. Weihnachtstag")
          (holiday-easter-etc  -2 "Karfreitag")
          (holiday-easter-etc  +1 "Ostermontag")
          (holiday-easter-etc +39 "Christi Himmelfahrt")
          (holiday-easter-etc +50 "Pfingstmontag")
          (holiday-easter-etc +60 "Fronleichnam")
          (holiday-fixed 11 1 "Allerheiligen"))))

(defun rrogg-org-calendar-specialdate ()
  "List of special dates, for Diary display in Org mode."
  (require 'holidays)
  (let ((hl (rrogg-calendar-check-specialdates org-agenda-current-date)))
    (and hl (mapconcat #'identity hl "; "))))

(defun rrogg-calendar-check-specialdates (date)
  "Check the list of special dates for any that occur on DATE.
DATE is a list (month day year).  This function considers the
special dates from the list `calendar-specialdates', and returns a list of
strings describing those special dates that apply on DATE, or nil if none do."
  (let ((displayed-month (calendar-extract-month date))
        (displayed-year (calendar-extract-year date))
        specialdate-list)
    (dolist (h (rrogg-calendar-specialdate-list) specialdate-list)
      (if (calendar-date-equal date (car h))
          (setq specialdate-list (append specialdate-list (cdr h)))))))

(defun rrogg-calendar-specialdate-list ()
  "Form the list of special dates that occur on dates in the calendar window.
The special dates are those in the list `calendar-specialdates'."
  (let (res h err)
    (sort
     (dolist (p rrogg-calendar-specialdates res)
       (if (setq h (if calendar-debug-sexp
                       (let ((debug-on-error t))
                         (eval p))
                     (condition-case err
                         (eval p)
                       (error
                        (display-warning
                         'specialdays
                         (format "Bad specialdate list item: %s\nError: %s\n"
                                 p err)
                         :error)
                        nil))))
           (setq res (append h res))))
     'calendar-date-compare)))

(setq rrogg-calendar-specialdates
      '((holiday-float 5 0 2 "Muttertag")
        (holiday-float 6 0 3 "Vatertag")
        (holiday-float 12 0 -4 "1. Advent" 24)
        (holiday-float 12 0 -3 "2. Advent" 24)
        (holiday-float 12 0 -2 "3. Advent" 24)
        (holiday-float 12 0 -1 "4. Advent" 24)
        (holiday-fixed 12 24 "Heiligabend")
        (holiday-fixed 1 6 "Heilige Drei Könige")
        (holiday-easter-etc -52 "Weiberfastnacht")
        (holiday-easter-etc -50 "Karnevalssamstag")
        (holiday-easter-etc -49 "Karnevalssonntag")
        (holiday-easter-etc -48 "Rosenmontag")
        (holiday-easter-etc -47 "Veilchendienstag")
        (holiday-easter-etc -46 "Aschermittwoch")
        (holiday-easter-etc -3 "Gründonnerstag")
        (holiday-easter-etc   0 "Ostersonntag")
        (holiday-easter-etc +49 "Pfingstsonntag")
        (holiday-fixed 8 15 "Mariae Himmelfahrt")
        (holiday-fixed 11 11 "Martinstag")
        (holiday-fixed 11 11 "Elfter im Elften")
        (holiday-float 11 3 1 "Buss- und Bettag" 16)
        (holiday-float 11 0 1 "Totensonntag" 20)))

(use-package solar
  :config
  (setq calendar-latitude [51 26 north]) ; Not my actual coordinates
  (setq calendar-longitude [6 45 east]))

(defun rrogg-org-calendar-solar ()
  "List of solar dates, for Diary display in Org mode."
  (require 'holidays)
  (let ((hl (rrogg-calendar-check-solar org-agenda-current-date)))
    (and hl (mapconcat #'identity hl "; "))))

(defun rrogg-calendar-check-solar (date)
  "Check the list of solar for any that occur on DATE.
DATE is a list (month day year).  This function considers the
special dates from the list `calendar-solar', and returns a list of
strings describing those solar that apply on DATE, or nil if none do."
  (let ((displayed-month (calendar-extract-month date))
        (displayed-year (calendar-extract-year date))
        solar-list)
    (dolist (h (rrogg-calendar-solar-list) solar-list)
      (if (calendar-date-equal date (car h))
          (setq solar-list (append solar-list (cdr h)))))))

(defun rrogg-calendar-solar-list ()
  "Form the list of solar that occur on dates in the calendar window.
The solar are those in the list `calendar-solar'."
  (let (res h err)
    (sort
     (dolist (p rrogg-calendar-solar res)
       (if (setq h (if calendar-debug-sexp
                       (let ((debug-on-error t))
                         (eval p))
                     (condition-case err
                         (eval p)
                       (error
                        (display-warning
                         'solar
                         (format "Bad solar list item: %s\nError: %s\n"
                                 p err)
                         :error)
                        nil))))
           (setq res (append h res))))
     'calendar-date-compare)))

(setq rrogg-calendar-solar
      '((holiday-sexp calendar-daylight-savings-starts
	                  (format "Beginn der Sommerzeit – die Uhr wird um eine Stunde vorgestellt %s"
		                      (solar-time-string
			                   (/ calendar-daylight-savings-starts-time . #1=((float 60)))
			                   calendar-standard-time-zone-name)))
        (holiday-sexp calendar-daylight-savings-ends
	                  (format "Ende der Sommerzeit – die Uhr wird um eine Stunde zurückgestellt %s"
		                      (solar-time-string
			                   (/ calendar-daylight-savings-ends-time . #1#)
			                   calendar-daylight-time-zone-name)))))

(use-package minibuffer
  :ensure nil
  :config
  (setq completion-styles '(basic substring initials flex orderless))
  (setq completion-category-overrides
        '((file (styles . (basic partial-completion orderless))))))

(use-package orderless
  :ensure t
  :demand t
  :after minibuffer
  :config
  (setq orderless-matching-styles '(orderless-prefixes orderless-regexp))
  :bind ( :map minibuffer-local-completion-map
          ("SPC" . nil)
          ("?" . nil)))
