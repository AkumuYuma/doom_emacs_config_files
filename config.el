;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Carico i file personali nella cartella elisp
(add-to-list 'load-path "~/.doom.d/elisp/")

;; Chiedo che vengano caricati i file singolarmente, così ho a disposizione le funzioni
(require 'exeroot)
(require 'funzioni-generiche)

;; ------------------------------------- Impostazioni personali -------------------------------

(setq user-full-name "Emanuele Fiorente"
      user-mail-address "manumanu1355@gmail.com")

(setq doom-theme 'doom-gruvbox)

(setq org-directory "~/orgNotes/")

(setq display-line-numbers-type `relative)

;; Nascondo i marker di enfasi nella org mode
(setq org-hide-emphasis-markers t)


;; Questo è un hook, praticamente si attiva quando parte la org mode (org-mode-hook) ed esegue la funzione passata come secondo argomento.
;; In questo caso ho scritto una lambda.
;; Cosa fa la lambda? Modifica la variabile org-file-apps (che contiene le applicazioni che la org mode fa partire quando deve aprire dei file).
;; In particolare cancello la riga ("\\.pdf\\'" . default) (che è quella di default che apre i pdf con emacs)
;; e la sostituisco con ("\\.pdf\\'" . "evince %s") (cioè chiedo che i pdf siano aperti con evince)
(add-hook 'org-mode-hook
          '(lambda ()
             (delete '("\\.pdf\\'" . default) org-file-apps)
             (add-to-list 'org-file-apps '("\\.pdf\\'" . "evince %s"))))

;; Come effetto è simile a:
;; (setq org-file-apps
;;       '((remote . emacs)
;;         (auto-mode . emacs)
;;         (directory . emacs)
;;         ("\\.mm\\'" . default)
;;         ("\\.x?html?\\'" . default)
;;         ("\\.pdf\\'" . "evince %s")))
;; Solo che con questo cambio la variabile dappertutto, in quel caso l'ho cambiata soltanto nella org mode.


;; --------------------------------------- Remaps ----------------------------------------------

;; Remap della evil mode
;; Frecce destra e sinistra per nuovo buffer
(define-key evil-normal-state-map (kbd "<right>") 'evil-next-buffer)
(define-key evil-normal-state-map (kbd "<left>") 'evil-prev-buffer)

;; Questo è un remap di doom. La sintassi è un po' diversa ma funziona bene
;; SPC-e-x per aprire l'explorer, è solo un remap comodo, fa esattamente quello che fa SPC-f-f
(map! :leader
      :desc "Apre l'explorer in una nuova finestra"
      "e x" #'find-file)

;; Remap generici
;; C-c t per aprire un terminale
(define-key global-map (kbd "C-c t") 'vterm)

;; C-c l per stampare l'intestazione nella org mode del linugaggio scelto
;; Viene usata questa sintassi diversa perchè faccio in modo che il keybinding valga solo nella org mode
(with-eval-after-load 'org
  (bind-key (kbd "C-c l") 'codice_linguaggio org-mode-map))

;; C-c C-r per tanglare e compilare la macro di root
(with-eval-after-load 'org
  (bind-key (kbd "C-c C-r") 'exeroot-tangla-e-compila-sezione org-mode-map))
