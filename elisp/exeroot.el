;;; elisp/exeroot.el -*- lexical-binding: t; -*-
;;
;; Pacchetto exeroot, insieme di funzioni da usare nella org mode.
;; Singolo comando, exeroot-tangla-e-compila-sezione, tangla in un file cpp, apre root e compila il code block. Così a quel punto devi solo eseguire la macro dentro root.

(defun exeroot--apri-terminale-e-compila (nome-file)
  "Apre un vterm ed esegue con root il file cpp passato come argomento. Bisogna passare il path relativo al buffer in cui si esegue la funzione"
  (let (( path-macro (concat "./" nome-file ) ))

    ;; Apro un nuovo buffer contenente un terminale
    (with-current-buffer (vterm)
      ;; progn garantisce la sequenzialità dei comandi
      (progn
        (vterm-send-string "root") ;; Scrivo root
        (vterm-send-return) ;; Premo invio
        (vterm-send-return) ;; Premo invio una seconda volta (devo aspettare che root sia avviato)
        (vterm-send-string (concat ".L " path-macro))
        (vterm-send-return) ;; Premo invio per compilare la macro
        )
      )
    )
  )


(defun exeroot--trova-nome-file ()
  "Restituisce il nome del file a cui il source block è tanglato. Nota che questa va eseguita posizionando il cursore nel code block, altrimenti non funziona.
Se il file contiene :tangle no, non restituisce niente"
  (save-excursion ;; Per non spostare il cursore
    (let ( (current-match (search-backward ":tangle" nil t)) ) ;; cerco all'indietro la parola :tangle
      (when current-match
        (setq current-match (skip-chars-forward ":tangle "))
        (let ( (output-file (thing-at-point 'filename t)) )
          (unless (string-equal output-file "no") ;; Se dopo :tangle ho "no", allora non restituisco niente
            output-file
            )
          )
        )
      )
    )
  )

(defun exeroot-tangla-e-compila-sezione ()
  "Eseguita dentro un source block, tangla il blocco con il nome e lo compila in root (con .L). Nota che se la usi fuori da un code block, org-babel-tangle-block fa partire un errore.
Se l'header ha l'opzione :tangle no, allora non fa niente"
  (interactive)
  (progn
    (org-babel-tangle-block)
    (let ( (nome-file (exeroot--trova-nome-file)) )
      (when nome-file
        (exeroot--apri-terminale-e-compila nome-file)
        )
      )
    )
  )


;; Serve per poter caricare le funzioni con (require 'exeroot) in config.el
(provide 'exeroot)
