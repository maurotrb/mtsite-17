+++
title      = "Strategia di backup personale"
date       = "2013-02-08T00:01:00+01:00"
type       = "article"
etichette  = [ "Programmazione", "Git", "Unison", "mr", "Robocopy", "TrueCrypt", "Backup" ]
slug       = "strategia-di-backup-personale"
+++

## Il problema
Uso un desktop Windows al lavoro, un altro a casa, e un portatile Linux durante il viaggio
casa-lavoro. Il portatile è per i progetti personali ed il desktop a casa e per la gestione
delle foto e del foto ritocco.
Molti file sono condivisi, per questo devo sincronizzarli tra i diversi computer.
Inoltre voglio avere una copia aggiornata dei file nel NAS casalingo, da cui posso fare
i backup.

<!--more-->
Ho iniziato qualche anno fa con una soluzione manuale: copiare i file tra i computer usando
una chiavetta USB. Ma era facile dimenticare qualcosa o sovrascrivere i file con vecchie
versioni.

Così mi sono messo alla ricerca di un metodo migliore.

Leggendo articoli e blog, ho trasformato i miei requisiti da avere una semplice copia sicura a
una soluzione completa di sincronizzazione e backup. Inoltre ho cercato di sviluppare
una soluzione più robusta e automatizzata.

## I requisiti
Per riassumere i requisiti, deve essere possibile:

* capire quali file sono cambiati su un computer e sincronizzarli facilmente con gli
  altri computer
* configurare la sincronizzazione per specificare quali file devono essere
  sincronizzati e quali no
* sincronizzare una copia aggiornata dei file più importanti in un posizione centralizzata
  da dove posso fare dei backup
* fare facilmente un backup o un restore dei file mantenendo più copie verificate
* usare la stessa procedura su Windows e Linux (dove possibile, vedere sotto)

Questi requisiti sono basati su due concetti chiave:

* __la sincronizzazione ed il backup devono essere facili__: se non fossero facili,
  non li farei così spesso, perdendo molti dei benefici di questa strategia
* __la sincronizzazione ed il backup sono due operazioni distinte__:
  la sincronizzazione riguarda la disponibilità dei file, il backup è un'assicurazione;
  forse si può usare lo stesso strumento, ma trattandoli separatamente si può disegnare
  una migliore strategia complessiva

## La soluzione (per ora)

### Sincronizzazione
La strategia di sincronizzazione si basa sul fatto di gestire diversamente i file di testo
ed i file binari.

I progetti software, i file di configurazione di Linux, i file di configurazione di Emacs,
documenti di testo e note, sono tutti gestiti in diversi repository Git, e sincronizzati
tramite una combinazione di progetti Bitbucket pubblici e privati. I progetti open source
sono sincronizzati anche su Github.
Uso [mr][] per clonare e combinare questi repository nella mia cartella _home_.
Con `mr update`, `mr status` e `mr push` posso facilmente gestire e sincronizzare le cartelle
_home_ dei miei sistemi Linux e Windows (Cygwin).

Documenti Office, file pdf, e immagini sono sincronizzati tra i computer usando il mio NAS
casalingo come un _hub_. La sincronizzazione è fatta con [Unison][] su Linux e con
[Allway Sync][aws] su Windows. Ho scelto strumenti differenti perché Allway Sync è più efficiente
in Windows, specialmente se si considera che dal mio desktop di casa sincronizzo il mio
archivio fotografico di più di 100 GB.

Questa strategia ha delle limitazioni importanti:

* Per sincronizzare i file di testo mi basta una connessione internet,
  ma posso sincronizzare i file binari solo a casa; per me questo non è un problema
  dato che i file binari mi servono tipicamente come bibliografia e quindi non
  ho bisogno di aggiornarli spesso
* il sistema funziona meglio se si usano di più i file di testo rispetto ai file binari
  (vedi il punto precedente); sto lentamente cambiando le mie abitudini passando da
  documenti Offici a file di testo, ma non ho rimpianti perché in questo modo ho
  imparato [Emacs][] e il suo fantastico [Org mode][orgmode]

Se hai bisogno di lavorare su sistemi multipli e puoi sopportare queste limitazioni,
guadagnerai in flessibilità e velocità.

### Backup
La strategia di backup è basta sul mio NAS casalingo, dove ho due gruppi di file:

* __irreplaceables__: se perdo questi file non ho modo di ricrearli; sono, per la
  maggior parte, i file sincronizzati tra i computer e verso il NAS stesso:
  progetti, documenti, note, foto
* __replaceables__: se perdo questi file li posso ricreare o riottenere in qualche
  modo (per esempio una copia di una foto esportata in un particolare formato,
  che posso ricreare dall'originale); sono in parte sincronizzati tra i computer
  ed in parte presenti solo sul NAS

I file _Replaceable_ sono sincronizzati verso un disco USB (500 GB) che tengo a casa.

I file _Irreplaceable_ sono sincronizzati verso due dischi USB (500 GB), che scambio
settimanalmente tra casa e lavoro. I dischi sono criptografati con [TrueCrypt][],
e la copia è verificato tramite _hash_ MD5 con [HaskDeep][].
In questo modo se succede qualche disastro, e perdo i dati sincronizzati sui mie
computer e sul NAS, ho una copia al sicuro che al massimo è vecchia di una settimana.

La sincronizzazione è fatto sul desktop Windows usando [Robocopy][].

## Bibliografia
Puoi trovare molti articoli e blog su sincronizzazione e backup.
Per quanto mi riguarda, quelli che mi sono stati più utili sono:

* [Subverting your homedir, or keeping your life in svn](http://joeyh.name/svnhome/)
* [Home Directory Synchronization](http://tratt.net/laurie/tech_articles/articles/home_directory_synchronization)
* [A basic non-cloud-based personal backup strategy](http://www.hanselman.com/blog/ABasicNoncloudbasedPersonalBackupStrategy.aspx)

[mr]: http://joeyh.name/code/mr/ "mr"
[unison]: http://www.cis.upenn.edu/~bcpierce/unison/ "Unison"
[aws]: http://allwaysync.com/ "Allway Sync"
[emacs]: http://www.gnu.org/software/emacs/ "Emacs"
[orgmode]: http://orgmode.org/ "Org mode"
[truecrypt]: http://www.truecrypt.org/ "TrueCrypt"
[haskdeep]: https://github.com/maurotrb/haskdeep "haskdeep"
[robocopy]: http://en.wikipedia.org/wiki/Robocopy "Robocopy"
