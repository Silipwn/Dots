;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "silipwn"
      user-mail-address "silipwned@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font tring ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "JetBrains Mono" :size 18)
      doom-big-font (font-spec :family "JetBrains Mono" :size 32)
      doom-unicode-font (font-spec :family "Fira Code")
      doom-variable-pitch-font (font-spec :family "Overpass" :size 20)
      doom-serif-font (font-spec :family "JetBrains Mono" :weight 'light))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/Org-Mode/Org-Mode")
(setq org-archive-location "%s-archive.org::")
;; Org-Agenda
(setq org-agenda-files
        '("/home/silipwn/Dropbox/Org-Mode/Org-Mode/mob-meta.org" "/home/silipwn/Dropbox/Org-Mode/Org-Mode/Logs/Telegram2Org.org"
          "/home/silipwn/Dropbox/Org-Mode/Org-Mode/Logs/gcal.org" "/home/silipwn/Dropbox/Org-Mode/Org-Mode/Purdue.org"
          "/home/silipwn/Dropbox/Org-Mode/Org-Mode/meta.org" "/home/silipwn/Dropbox/Org-Mode/Org-Mode/todo.org" "/home/silipwn/Dropbox/Org-Mode/Org-Mode/misc.org"))
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
;; Time
(setq display-time-24hr-format t)
;;
(setq-default
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…"                ; Unicode ellispis are nicer than "...", and also save /precious/ space
      scroll-preserve-screen-position 'always     ; Don't have `point' jump around
      scroll-margin 2)                            ; It's nice to maintain a little margin
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Changelog
;; #1 - 2021-07-28T13:11:33+0530: silipwn: Refactoring first time

; Adding my config here
; Loading local stuff
(use-package header2 :load-path "~/.doom.d/local")
;; Auto update file
(autoload 'auto-update-file-header "header2")
(add-hook 'write-file-functions 'auto-update-file-header)
(use-package writegood-mode :load-path "~/.doom.d/local")
(use-package hypothesis :load-path "~/.doom.d/local")
;; Hypo stuff
(setq hypothesis-username "silipwn")

;; Org-Journal
;; (setq org-journal-dir "~/Dropbox/Org-Mode/Org-Mode/SABS/Journal"
;; org-journal-file-format "%Y/%m/%d-%m-%Y.org"
;; org-journal-file-type 'daily
;; org-journal-enable-encryption t
;; ;; org-journal-date-prefix "* "
;; org-journal-time-prefix "*** "
;; org-journal-enable-agenda-integration t
;; ;; org-journal-file-header ""
;; )
;; Removed cause creates daily note with same header
;; (defun org-journal-file-header-func (time)
;;   "Custom function to create journal header."
;;   (concat
;;     (pcase org-journal-file-type
;;       (`daily "#+TITLE: Daily Journal\n#+STARTUP: showeverything")
;;       (`weekly "#+TITLE: Weekly Journal\n#+STARTUP: folded")
;;       (`monthly "#+TITLE: Monthly Journal\n#+STARTUP: folded")
;;       (`yearly "#+TITLE: Yearly Journal\n#+STARTUP: folded"))))
;; (setq org-journal-file-header 'org-journal-file-header-func)
;; Hooks for org-journal
;; (add-hook 'org-journal-after-header-create-hook 'org-journal-daily-todo)
;; ;; (add-hook 'org-journal-after-entry-create-hook 'clock-in-journal)
;; (defun org-journal-daily-todo ()
;;   (insert "\n** Daily Todo [/] \n*** TODO \n** Thoughts :crypt:\n"))
;; Org-clock
(org-clock-persistence-insinuate)
(setq org-clock-x11idle-program-name "xprintidle")
(setq org-clock-idle-time 60)
(setq org-clock-history-length 23)
(setq org-clock-in-resume t)
(setq org-clock-in-switch-to-state 'bh/clock-in-to-next)
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Log state into Logbook
;; https://orgmode.org/manual/Tracking-TODO-state-changes.html#Tracking-TODO-state-changes
(setq org-log-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist t)
;; Do not prompt to resume an active clock
(setq org-clock-persist-query-resume nil)
;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)
;; Ptreyy clock
(setq org-pretty-entities t)
;; Visual
(setq org-hide-leading-stars t)
;; Org-clock sound
;; 2021-07-05T11:48:27+0530: Update for more useful sound : silipwn
(setq org-clock-sound "/home/silipwn/Dropbox/Org-Mode/Org-Mode/bell_sound.wav")
;; Since Doom disabled ring-bell enable it
(setq ring-bell-function t)
;; Create feedback sounds for org-clock in
(defun org-feedback-reward ()
  (when (string-equal org-state "DONE")
  (start-process-shell-command "sounds" nil "paplay /usr/share/sounds/freedesktop/stereo/complete.oga")))

  ;; To avoid playing with playerctl
  ;; (start-process-shell-command "sounds" nil "mpv --really-quiet --volume=85 /usr/share/sounds/freedesktop/stereo/eventually.wav")))

(defun org-feedback-sound ()
  (start-process-shell-command "sounds" nil "paplay /usr/share/sounds/freedesktop/stereo/complete.oga"))
 ;; (play-sound-file "/usr/share/sounds/freedesktop/stereo/anxious.wav"))
;; Add hooks for calling sounds
(add-hook 'org-clock-in-hook 'org-feedback-sound 'append)
(add-hook 'org-after-todo-state-change-hook 'org-feedback-reward)
;; Convience Agenda
(use-package! org-clock-convenience
  ;; :ensure t
  :bind (:map org-agenda-mode-map
         ("<S-up>" . org-clock-convenience-timestamp-up)
         ("<S-down>" . org-clock-convenience-timestamp-down)
         ("o" . org-clock-convenience-fill-gap-both)))
;; Remove excess empty logbooks
(defun bh/remove-empty-drawer-on-clock-out ()
   (interactive)
   (save-excursion
     (beginning-of-line 0)
     (org-remove-empty-drawer-at (point))))

(add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)

;; Auto-save after clock
(add-hook 'org-clock-in-hook 'save-buffer 'append)
(add-hook 'org-clock-out-hook 'save-buffer 'append)
;; BH functions
(defun bh/clock-in-to-next (kw)
  "Switch a task from TODO to STRT when clocking in.
Skips capture tasks, projects, and subprojects.
Switch projects and subprojects from STRT back to TODO"
  (when (not (and (boundp 'org-capture-mode) org-capture-mode))
    (cond
     ((and (member (org-get-todo-state) (list "TODO"))
           (bh/is-task-p))
      "STRT")
     ((and (member (org-get-todo-state) (list "STRT"))
           (bh/is-project-p))
      "TODO"))))

(defun bh/is-task-p ()
  "Any task with a todo keyword and no subtask"
  (save-restriction
    (widen)
    (let ((has-subtask)
          (subtree-end (save-excursion (org-end-of-subtree t)))
          (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
      (save-excursion
        (forward-line 1)
        (while (and (not has-subtask)
                    (< (point) subtree-end)
                    (re-search-forward "^\*+ " subtree-end t))
          (when (member (org-get-todo-state) org-todo-keywords-1)
            (setq has-subtask t))))
      (and is-a-task (not has-subtask)))))
(defun bh/is-project-p ()
  "Any task with a todo keyword subtask"
  (save-restriction
    (widen)
    (let ((has-subtask)
          (subtree-end (save-excursion (org-end-of-subtree t)))
          (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
      (save-excursion
        (forward-line 1)
        (while (and (not has-subtask)
                    (< (point) subtree-end)
                    (re-search-forward "^\*+ " subtree-end t))
          (when (member (org-get-todo-state) org-todo-keywords-1)
            (setq has-subtask t))))
      (and is-a-task has-subtask))))

;; Default entry?
(defvar bh/organization-task-id "eb155a82-92b2-4f25-a3c6-0304591af2f9")
(defvar journal-task-id "bbeae3c4-ee5c-49cd-adbf-5f374b08d071")
(defvar meta-task-id "ef673155-f37d-4ab0-94ec-6f4858d29c6c")

(defun bh/clock-in-organization-task-as-default ()
  (interactive)
  (org-with-point-at (org-id-find bh/organization-task-id 'marker)
    (org-clock-in '(16))))

(defun meta-clock-in ()
  (interactive)
  (org-with-point-at (org-id-find meta-task-id 'marker)
    (org-clock-in '(16))))
;; 2021-07-28T13:08:00+0530: silipwn: Enabled again
;; interferes with org-roam
(add-hook 'org-capture-prepare-finalize-hook 'org-id-get-create)
;; From the great BH
(setq org-clone-delete-id t)

(setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)
;; https://koenig-haunstetten.de/2018/02/17/improving-my-orgmode-workflow/
;; (defun koenig/copy-idlink-to-clipboard() "Copy an ID link with the
;; headline to killring, if no ID is there then create a new unique
;; ID.  This function works only in org-mode or org-agenda buffers.

;; The purpose of this function is to easily construct id:-links to
;; org-mode items. If its assigned to a key it saves you marking the
;; text and copying to the killring."
;;        (interactive)
;;        (when (eq major-mode 'org-agenda-mode) ;switch to orgmode
;;      (org-agenda-show)
;;      (org-agenda-goto))
;;        (when (eq major-mode 'org-mode) ; do this only in org-mode buffers
;;      (setq mytmphead (nth 4 (org-heading-components)))
;;          (setq mytmpid (funcall 'org-store-link))
;;      (setq mytmplink (format "[[%s][%s]]" mytmpid mytmphead))
;;      (kill-new mytmplink)
;;      (message "Copied %s to killring (clipboard)" mytmplink)
;;        ))
(map! :leader "l b" #'org-mark-ring-goto)
;; Org-Capture
(setq org-capture-templates
      (quote (("t" "todo" entry (file+headline "meta.org" "Inbox")
               "* TODO %? \n%U\n")
              ("T" "Scheduled Todo" entry (file+headline "misc.org" "Inbox")
               "* TODO %? %^G \n%T")
              ("n"  "Note" entry (file "Notebook.org")
               "\n* %?\n  Context:\n    %i\n  Entered on %U")
              ("c" "Phone call" entry (file+headline "meta.org" "Calls")
               "* On call with %? :phone:\n%T\n** Notes\n** Action Items" :clock-in t :clock-resume t)
              ("L" "Website Link" entry (file+headline "meta.org" "Links")
               "* TODO Check this out: [[%:link][%:description]] :links:someday:\nCaptured On:%U\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+3d\"))" :immediate-finish t)
              ("R" "Youtube Link" entry (file+headline "meta.org" "Youtube")
               "* TODO Video: [[%:link][%:description]] :media:someday:\nCaptured On:%U\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+3d\"))" :immediate-finish t)
              ("m" "Templates for Meetings")
              ("mm" "Scheduled Meeting" entry (file+headline "misc.org" "Meetings")
               "* In MEETING with %^{Who are you meeting with and for what?} :meeting:\n%^T\n%U\n** Pre-meeting notes\n** Notes\n** Action Items")
              ("mM" "Clocked Meeting" entry (file+headline "meta.org" "Meetings")
               "* In MEETING with  %^{Who are you meeting with and for what?}  :meeting:\n%^T\n** Pre-meeting notes\n** Notes\n** Action Items" :clock-in t :clock-resume t)
              ("mn" "Notes" entry (file+headline "meta.org" "Notes")
                "* %u %?\n%T\n** Pre-meeting notes\n** Notes\n** Action Items" :prepend t)
              ;; Weird template for Zoterp
              ;; ("mb" "Website Bibtex Link" entry (file "~/Dropbox/main.bib")
              ;;  " @misc{%?,\ntitle={%:description},\nauthor ={},\nyear ={},\nurl={%:link (Accessed On:%U)},\nnote={Accessed On:%U}}")
              ("M" "Templates for Misc")
              ("Mi" "Interrupt" entry (file "meta.org")
               "* TODO Interrupt by %? cause %? :interrupt:\n%U" :clock-in t :clock-resume t)
              ("My" "Media" entry (file+headline "meta.org" "Media")
               "* Seeing %? :media:\n%U" )
              ("Ma" "Break" item (file+headline "meta.org" "Bored")
               "* Taking a break :) \n%U" :clock-in t :clock-resume t)
              ("Mh" "Habit" entry (file "meta.org")
               "* TODO %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: TODO\n:END:\n")
              ("Mr" "respond" entry (file+headline "misc.org" "Mail-Inbox")
               "* TODO Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :immediate-finish t)
              ("Ms" "Ideas" entry (file+headline "meta.org" "Ideas")
               "* Idea about %? :idea:\n%U" :clock-in t :clock-resume t)

              ("j" "Templates for Journals")
              ("jt" "Daily Plan" entry (file+olp+datetree "SABS/Journal/private-log.org")
                "* Daily Plan for %u\n** Timeline\n|Slot|Planned|Updates|\n| Morning  |  |  |\n| Afternoon |  |  |\n| Evening |  |  |\n** Grateful for: \n** End of the day Review: %?" :tree-type week)

              ("jr" "Rants/Thoughts" entry (file+olp+datetree "SABS/Journal/private-log.org")
                "* Rants/Thoughts - %U :thought:\n:PROPERTIES:\n:Mood: %^{What is your mood(One word)}\n:Severity: %^{Rate severity of mood from 1-10:}\n:END:\n \n %?" :tree-type week)
              ("jl" "Logs" entry (file+olp+datetree "SABS/Journal/private-log.org")
                "* Logs - %U\nCurrently on: %k\n\n%?" :tree-type week)
              ("jk" "Note" entry (file+olp+datetree "SABS/Journal/private-log.org")
                "* Note - %U :note:\nCurrently on: %k\n\n%?" :tree-type week)
              ("js" "Secret" entry (file+olp+datetree "SABS/Journal/private-log.org")
                "* Secrets - %U :crypt:\n\n%? " :tree-type week)

              ("p" "Templates for projects")
                ("pn" "Project-local notes" entry  ; {project-root}/notes.org
                (file+headline +org-capture-project-notes-file "Notes")
                "* %U %?\n%i\n%a" :prepend t)
                ("pf" "Project-local Features" entry  ; {project-root}/changelog.org
                (file+headline +org-capture-project-changelog-file "Features")
                "* %U %?\n%i\n%a" :prepend t)
                ("pl" "Project-local Logs" entry  ; {project-root}/changelog.org
                (file+headline +org-capture-project-notes-file "Logs")
                "* %U %?\n%i\n%a" :prepend t)
                ("ps" "Code Snippet" entry
                (file+headline +org-capture-project-notes-file "Mods")
                ;; Prompt for tag and language
                "* %?\t%^g\n#+BEGIN_SRC %^{language} \n\n#+END_SRC")

              ("f" "Templates for generic notes")
                ("fn" "Project-local notes" entry  ; {project-root}/notes.org
                (file+headline "Inbox-Notes.org" "Notes")
                "* %U %? %^G\n\n%a" :prepend t)
                ("fl" "Project-local Logs" entry  ; {project-root}/changelog.org
                (file+headline "Inbox-Notes.org" "Logs")
                "* %U %?\n%x\n%a" :prepend t)
                ("fs" "Code Snippet" entry
                (file+headline "Inbox-Notes.org" "Mods")
                ;; Prompt for tag and language
                "* %?\t%^g\n#+BEGIN_SRC %^{language} \n\n#+END_SRC")
                )))

;; Org-Super-Agenda
(setq org-agenda-custom-commands
      '(("c" "Super Agenda" agenda
         (org-super-agenda-mode)
         ((org-super-agenda-groups
           '((:name "Schedule"
                :time-grid t)
           (:name "Today"
                :scheduled today)
           (:name "Personal"
            :habit t)
           (:name "Started"
            :todo ("STRT"))
           (:name "Due today"
                :deadline today)
           (:name "Overdue"
                :deadline past)
           (:name "Quick Picks"
                    :effort< "0:30")
           (:name "Due soon"
                :deadline future)
           (:name "Scheduled earlier"
            :scheduled past)
           ))))
        ("q" "Tiny agenda" agenda "Today's shiz"
         ( org-agenda-start-with-log-mode (org-agenda-files
        '("/home/silipwn/Dropbox/Org-Mode/Org-Mode/mob-meta.org" "/home/silipwn/Dropbox/Org-Mode/Org-Mode/Logs/Telegram2Org.org"
          "/home/silipwn/Dropbox/Org-Mode/Org-Mode/Logs/gcal.org"
          "/home/silipwn/Dropbox/Org-Mode/Org-Mode/meta.org" "/home/silipwn/Dropbox/Org-Mode/Org-Mode/todo.org" "/home/silipwn/Dropbox/Org-Mode/Org-Mode/misc.org"))))))
;; Agenda log mode items to display (closed and state changes by default)
(setq org-agenda-log-mode-items (quote (closed state)))

;; Allow setting single tags without the menu
(setq org-fast-tag-selection-single-key (quote expert))

;; For tag searches ignore tasks with scheduled and deadline dates
(setq org-agenda-tags-todo-honor-ignore-options t)

;; Agenda-Clockreport
;; :formula "$5=($3+$4)*(60/25);t"
;; http://emacs.stackexchange.com/questions/12839/use-formula-in-agenda-clockreport-to-convert-time
(setq org-agenda-clockreport-parameter-plist '(:link t :maxlevel 6 :formula %))


;; Org-faces
(setq org-todo-keyword-faces '(("TODO" . org-todo)
                               ;; ("STRT" . org-ongoing)
                               ("HOLD" . org-holding)
                               ("PROJ" . org-todo-project)
                               ("DONE" . org-done)
                               ("ABRT" . org-cancelled)))

;; Pop-up for Agenda-appt
(setq
  appt-message-warning-time 5 ;; warn 15 min in advance
  appt-display-mode-line nil     ;; show in the modeline
  appt-display-interval 5
  appt-display-format 'window) ;; use our func
(appt-activate 1)              ;; active appt (appointment notification)
(display-time)                 ;; time display is required for this...

 ;; update appt each time agenda opened
(add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt)
(add-hook! 'org-agenda-mode-hook 'buffer-disable-undo 'append)

;; Appt data from org mode
(defun my-org-agenda-to-appt ()
  (interactive)
  (setq appt-time-msg-list nil)
  (org-agenda-to-appt))
(setq appt-disp-window-function 'my-appt-display)
(setq appt-delete-window-function (lambda () t))

(run-at-time "24:01" nil 'my-org-agenda-to-appt)

(setq my-appt-notification-app "/home/silipwn/Developments/Org/app-notify")

(defun my-appt-display (min-to-app new-time msg)
  (if (atom min-to-app)
    (start-process "my-appt-notification-app" nil my-appt-notification-app min-to-app msg)
  (dolist (i (number-sequence 0 (1- (length min-to-app))))
    (start-process "my-appt-notification-app" nil my-appt-notification-app (nth i min-to-app) (nth i msg)))))

;; Org-crypt
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
(setq org-crypt-key "8A910F3CC8FD03E669F2B4D32EE54940706B31C0")

;; Dired Download
(add-hook 'dired-mode-hook 'org-download-enable)

;; Org-download
(setq org-download-method 'directory)
(setq-default org-download-image-dir "./images")

;; Removing Download link cause that doesn't work well with export
(setq org-download-link-format "[[file:img/%s]]\n")
(setq org-download-screenshot-method "scrot")

;; Bibtex customizations
(setq reftex-default-bibliography '("~/Dropbox/main.bib" "~/Dropbox/to_read.bib"))
(map! :leader "o p" #'org-ref-open-pdf-at-point)
(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
        "bibtex %b"
        "pdflatex -interaction nonstopmode -output-directory %o %f"
        "pdflatex -interaction nonstopmode -output-directory %o %f"))
;; see org-ref for use of these variables
(setq org-ref-default-bibliography '("~/Dropbox/main.bib" "~/Dropbox/to_read.bib")
      ;; org-ref-notes-function 'orb-note-actions
      org-ref-pdf-directory "~/Docs/Zotero/storage")
;; Adapted from https://github.com/deerpig/dot-emacs/blob/5a0f46327d6515847ba16098829f997a89bf7a84/dot-packages.org
;; org-ref-bibliography-notes "~/Dropbox/Org-Mode/Org-Mode/notes.org"
(setq org-ref-note-title-format "** %y - %t\n :PROPERTIES:\n  :Custom_ID: %k\n  :AUTHOR: %9a\n  :JOURNAL: %j\n  :YEAR: %y\n  :VOLUME: %v\n  :PAGES: %p\n  :DOI: %D\n  :URL: %U\n  :INTERLEAVE_PDF: ./lib/%k.pdf\n:END:\n\n")
;; Ivy-bibtex
(setq bibtex-completion-bibliography '("~/Dropbox/main.bib" "~/Dropbox/to_read.bib")
      bibtex-completion-library-path '("~/Docs/Papers/" "~/Docs/Zotero/storage/")
      ivy-bibtex-notes-path "~/Dropbox/Org-Mode/Org-Mode/SABS/Literature"
      bibtex-completion-notes-path "~/Dropbox/Org-Mode/Org-Mode/SABS/Literature"
      bibtex-completion-pdf-field "File"
      bibtex-completion-pdf-symbol "P"
      bibtex-completion-notes-symbol "N")

;; Hugo+Org-ref
(use-package citeproc-org
  :after ox-hugo
  :config
  (citeproc-org-setup))

;; Using avy for all windows ;)
(setq avy-all-windows t)

;; Email
;; Functions
;; Fri Jun 11 22:40:23 2021 https://git.sr.ht/~tslil/dotfiles/tree/master/emacs/notmuch-config.el
;; ===================================================================
;; notmuch-hello widgets and offlineimap integration
;; (defun notmuch-hello-header-new ()
;;   (setq fill-column (window-width))
;;   (let ((widget-link-prefix "")
;;         (widget-link-suffix "")
;;         (unread (string-to-number (car (process-lines
;;                                         notmuch-command "count" "tag:unread"))))
;;         (total (string-to-number (car (process-lines
;;                                        notmuch-command "count")))))
;;     (widget-insert "You have ")
;;     (widget-create 'link :notify (lambda (&rest nope) (notmuch-hello-update))
;;                    :help-echo "Update notmuch view"
;;                    (notmuch-hello-nice-number total))
;;     (widget-insert " emails,")
;;     (center-line) (widget-insert "\n")
;;     (widget-create 'link :notify (lambda (&rest nope) (notmuch-tree "tag:unread"))
;;                    :help-echo "View unread emails"
;;                    (notmuch-hello-nice-number unread))
;;     (widget-insert (format " of which %s unread."
;;                            (if (= 1 unread) "is" "are")))
;;     (center-line) (widget-insert "\n")))

;; Notmuch
(use-package! notmuch
  :commands (notmuch)
  :init
  (map! :desc "notmuch" "<f9>" #'notmuch-tree)
  ;; (map! :map notmuch-search-mode-map
  ;;       :desc "toggle read" "t" #'+notmuch/toggle-read
  ;;       :desc "Reply to thread" "r" #'notmuch-search-reply-to-thread
  ;;       :desc "Reply to thread sender" "R" #'notmuch-search-reply-to-thread-sender)
  ;; (map! :map notmuch-show-mode-map
  ;;       :desc "Next link" "<tab>" #'org-next-link
  ;;       :desc "Previous link" "<backtab>" #'org-previous-link
  ;;       :desc "URL at point" "C-<return>" #'browse-url-at-point)
  :config
  (setq message-auto-save-directory "~/Docs/.mail/drafts/"
        notmuch-address-command 'internal
        message-send-mail-function 'message-send-mail-with-sendmail
        sendmail-program (executable-find "msmtp")
        message-sendmail-envelope-from 'header
        mail-envelope-from 'header
        mail-specify-envelope-from t
        message-sendmail-f-is-evil nil
        message-kill-buffer-on-exit t
        message-citation-line-function 'message-insert-formatted-citation-line
        message-citation-line-format "On %Y-%m-%d at %R %Z, %f wrote..."
        notmuch-always-prompt-for-sender t
        notmuch-crypto-process-mime t
        ;; notmuch-hello-sections '(notmuch-hello-header-new notmuch-hello-insert-saved-searches)
        notmuch-search-oldest-first nil
        notmuch-fcc-dirs '(("ashwin.nambiar@imdea.org" . ".Sent +sent -unread"))
        notmuch-archive-tags '("-inbox" "-unread")
        notmuch-message-headers '("To" "Cc" "Subject" "Bcc")
        notmuch-saved-searches '((:name "inbox" :query "tag:inbox" :sort-order 'newest-first :search-type 'tree)
                                 (:name "unread" :query "tag:inbox and tag:unread")
                                 (:name "to-me" :query "tag:inbox and tag:to-me")
                                 ;; (:name "official" :query "tag:inbox and tag:official")
                                 ;; (:name "imdea" :query "tag:inbox and tag:imdea")
                                 ;; (:name "statusup" :query "tag:inbox and tag:statusup")
                                 (:name "drafts" :query "tag:draft"))))
(setq +notmuch-sync-backend 'mbsync)
(after! notmuch (set-popup-rule! "^\\*notmuch-hello" :ignore t))
    ;; (notmuch-address-message-insinuate)
(setq fortune-dir "/usr/share/fortune")
(setq fortune-file "/usr/share/fortune/softwareengineering")
(setq message-signature 'nil)
;; Custom function to insert the signature
(defun message-insert-signature-at-point () "Insert signature at point."
(interactive) (require 'message) (save-restriction (narrow-to-region (point) (point))
(message-insert-signature)))

;; Ox-hugo
(use-package ox-hugo
  ;; :ensure t            ;Auto-install the package from Melpa (optional)
  :after ox)
(setq org-hugo-auto-set-lastmod t)
;; Standard Effort
(add-hook 'org-clock-in-prepare-hook
          'my-org-mode-add-default-effort)
(defvar org-clock-default-effort "0:30")
(defun my-org-mode-add-default-effort ()
  "Add a default effort estimation."
  (unless (org-entry-get (point) "Effort")
    (org-set-property "Effort" org-clock-default-effort)))
;; Org-mru-clock
(map! :leader "m c p" #'org-mru-clock-in)
(use-package org-mru-clock
  ;; :ensure t
  :init
  (setq org-mru-clock-how-many 20
        org-mru-clock-completing-read #'ivy-completing-read))
;; Org-habit
(require 'org-habit)
;; Add checkbox stuff
(require 'org-checklist)
;; Use bash cause fish fucksup
(setq shell-file-name "/usr/bin/fish")
;; For the clock-report to show stuff in hours
(setq org-duration-format (quote h:mm))
; Tramp issues
(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))
;; (setq tramp-chunksize 2000)
(map! :leader "o s" #'counsel-tramp)
(defadvice! doom--projectile-locate-dominating-file-a (file _name)
    "Don't traverse the file system if on a remote connection."
    :before-while #'projectile-locate-dominating-file
    (and (stringp file)
         (not (file-remote-p file nil t))))
(setq vc-handled-backends '(Git))
;; Copy headers via refile
(map! :leader "m r t" #'org-refile-copy)
;; Org-Rifle
(map! :leader "o q" #'helm-org-rifle)

;; i3-Status?
;; Based on Bendersteed
;;https://bendersteed.tech/posts/org-mode-clock-in-i3blocks.html
(defun i3-org-clock-indicator ()
  (if (org-clocking-p) ; check if org-clock is active
    (format "⏹ '%s' for %d min."
            org-clock-heading
            (org-clock-get-clocked-time))
    (format "◷ Yo? Clock in!")))
;; Ignore headlines based on
;; https://github.com/hlissner/doom-emacs/issues/2409
(after! ox
  (require 'ox-extra)
  (ox-extras-activate '(ignore-headlines)))

;; Company
(after! company
  (setq company-idle-delay 0.5
        company-minimum-prefix-length 2)
  (setq company-show-quick-access t)
  (add-hook 'evil-normal-state-entry-hook #'company-abort)) ;; make aborting less annoying.

(setq-default history-length 1000)
(setq-default prescient-history-length 1000)
;; https://www.reddit.com/r/DoomEmacs/comments/nb7l95/how_to_get_companyfiles_backend_working_with/
(add-to-list '+lsp-company-backends 'company-files 'company-dabbrev 'company-dabbrev-code)
;; LSP Don't need to read all files
(setq lsp-enable-file-watchers nil)
;; Tue Jun  8 08:29:27 2021 Add 80 char limit
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
;; Thu Jun 10 17:42:56 2021 Split and ask which to load
;; Source:https://tecosaur.github.io/emacs-config/config.html
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  ;; Added own function here Wed Jun 16 23:00:44 2021
  (counsel-find-file))
(setq evil-vsplit-window-right t
      evil-split-window-below t)
(setq +ivy-buffer-preview t)

(setq ivy-read-action-function #'ivy-hydra-read-action)
;; Thu Jun 10 19:22:19 2021 Avy window
(map! :leader "w a" #'ace-window)
;; Fri Jun 11 16:03:54 2021
(setq-default major-mode 'org-mode)

(set-company-backend!
  '(text-mode
    markdown-mode
    gfm-mode)
  '(:seperate
    company-ispell
    company-files
    company-yasnippet
    company-dabbrev
    company-dabbrev-code
    ))
;; 2021-07-28T23:09:46+0530: silipwn: Refactor
(use-package! vlf-setup
  :defer-incrementally vlf-tune vlf-base vlf-write vlf-search vlf-occur vlf-follow vlf-ediff vlf)
(setq yas-triggers-in-field t)

;; 2021-07-29T19:39:56+0530: silipwn: Add window titles
(setq doom-fallback-buffer-name "► Doom"
      +doom-dashboard-name "► Doom")
(setq frame-title-format
      '(""
        (:eval
         (if (s-contains-p org-directory (or buffer-file-name ""))
             (replace-regexp-in-string
              ".*/[0-9]*-?" "☰ "
              (subst-char-in-string ?_ ?  buffer-file-name))
           "%b"))
        (:eval
         (let ((project-name (projectile-project-name)))
           (unless (string= "-" project-name)
             (format (if (buffer-modified-p)  " ◉ %s" "  ●  %s") project-name))))))


(setq flycheck-emacs-lisp-load-path 'nil)
(use-package! ox-gfm
  :after org)
