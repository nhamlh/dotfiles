;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Nham Le"
      user-mail-address "lehoainham@gmail.com")

;; UI
(setq doom-font (font-spec :family "Fira Code" :size 18))
(setq doom-theme 'doom-solarized-light)
(setq display-line-numbers-type 'relative)
;; Enable modeline for popup windows
(plist-put +popup-defaults :modeline t)
(setq doom-scratch-buffer-major-mode 'emacs-lisp-mode)

;; Orgmode
(after! org
  (setq org-directory "~/org/")
  (setq org-ellipsis "  ")

  ;; foreground red is suitable for light theme, cyan for dark theme
  (custom-set-faces '(org-ellipsis ((t (:foreground "red" :weight bold)))))
  ;; Only show the first occurrent of repeated tasks in the agenda
  (setq org-agenda-show-future-repeats 'next)
  ;; Don't auto-insert newline for orgmode buffer, instead wrap long lines
  (remove-hook 'text-mode-hook #'auto-fill-mode)

  (custom-declare-face '+org-todo-next '((t (:inherit (bold font-lock-doc-face org-todo)))) "")
  (custom-declare-face '+org-todo-strt '((t (:inherit (bold font-lock-doc-face org-todo)))) "")

  (setq org-todo-keywords
        '((sequence
           "TODO(t)"  ; A task that needs doing
           "NEXT(n)"  ; Task need to focus next
           "STRT(s)"  ; Task is in progress
           "WAIT(w)"  ; Task is being held up or paused
           "|"
           "DONE(d)"
           "KILL(k)")
          (sequence
           "[ ](T)"   ; A task that needs doing
           "[-](S)"   ; Task is in progress
           "[?](W)"   ; Task is being held up or paused
           "|"
           "[X](D)"))
        org-todo-keyword-faces
        '(("TODO" . +org-todo-active)
          ("[ ]"  . +org-todo-active)
          ("NEXT" . +org-todo-next)
          ("STRT" . +org-todo-strt)
          ("[-]"  . +org-todo-active)
          ("WAIT" . +org-todo-onhold)
          ("[?]"  . +org-todo-onhold)))

  (setq org-agenda-show-all-dates 0)

  (setq
   org-work-files (list (concat (file-name-as-directory org-directory) "work.org"))
   org-gtd-files (list (concat (file-name-as-directory org-directory) "gtd.org"))
   org-test-files (list (concat (file-name-as-directory org-directory) "test.org"))

   org-agenda-custom-commands
        '(("g" "Getting things done"
           ((agenda ""
                    ((org-agenda-files org-gtd-files)
                     (org-agenda-span 7)
                     (org-agenda-show-all-dates nil)
                     (org-agenda-overriding-header "This week: ")))
            (todo "STRT" ((org-agenda-overriding-header "Underway: ")
                          (org-agenda-files org-gtd-files)))
            (todo "NEXT" ((org-agenda-overriding-header "To do next: ")
                          (org-agenda-files org-gtd-files)))
            (tags-todo "+PRIORITY=\"A\"" ((org-agenda-overriding-header "Important: ")
                          (org-agenda-files org-gtd-files)))))
          ("t" "Test agenda"
           ((agenda ""
                    ((org-agenda-files org-test-files)
                     (org-agenda-span 7)
                     (org-agenda-show-all-dates nil)
                     (org-agenda-overriding-header "This week: ")))
            (todo "STRT" ((org-agenda-overriding-header "Underway: ")
                          (org-agenda-files org-test-files)))
            (todo "NEXT" ((org-agenda-overriding-header "To do next: ")
                          (org-agenda-files org-test-files)))
            (tags-todo "TODO=\"TODO\"+PRIORITY=\"A\"" ((org-agenda-overriding-header "Important: ")
                                                       (org-agenda-files org-test-files)))
            (tags-todo "TODO=\"WAIT\"+PRIORITY=\"A\"" ((org-agenda-overriding-header "Stuck important tasks: ")
                          (org-agenda-files org-test-files)))))
          ("w" "Tasks at Work"
           ((agenda ""
                    ((org-agenda-files org-work-files)
                     (org-agenda-span 7)
                     (org-agenda-show-all-dates nil)
                     (org-agenda-overriding-header "This week: ")))
            (todo "STRT" ((org-agenda-overriding-header "Underway: ")
                          (org-agenda-files org-work-files)))
            (todo "NEXT" ((org-agenda-overriding-header "To do next: ")
                          (org-agenda-files org-work-files)))
            (tags-todo "+PRIORITY=\"A\"" ((org-agenda-overriding-header "Important: ")
                          (org-agenda-files org-work-files))))))))

(after! projectile
  ;; Init projectile's search dirs
  (setq projectile-project-search-path (split-string (getenv "EMACS_PROJECTILE_SEARCH_DIRS") ";")))

(after! auto-dim-other-buffers
  ;; Better focusing on current buffer
  (auto-dim-other-buffers-mode))

(defun nhamlh/projectile-new-git-project ()
  "Intitialize new git project in one of directories of projectile-project-search-path,
then open a new workspace with this new project"
  (interactive)

   (let ((directory (file-name-as-directory
                     (expand-file-name
                      (ivy-read
                       "Create project in: "
                       projectile-project-search-path
                       :caller 'nhamlh/projectile-new-project))))
         (name (read-string "Project name: ")))

     (let ((project (expand-file-name (concat (file-name-as-directory directory) name))))

       (when-let ((toplevel (magit-toplevel project)))
         (setq toplevel (expand-file-name toplevel))
         (unless (y-or-n-p (if (file-equal-p toplevel project)
                             (format "Reinitialize existing repository %s? "
                                     project)
                           (format "%s is a repository.  Create another in %s? "
                                   toplevel project)))
         (user-error "Abort")))

       (magit-call-git "init" (magit-convert-filename-for-git project))
       (setq projectile-switch-project-action 'magit-status-setup-buffer)
       (projectile-switch-project-by-name project))))

(after! ivy
  (setq counsel-projectile-rg-initial-input '(ivy-thing-at-point)))

(after! magit
  (set-popup-rule! "^magit:\s" :height 0.5 :side 'bottom :select t :modeline t :quit 'current))
