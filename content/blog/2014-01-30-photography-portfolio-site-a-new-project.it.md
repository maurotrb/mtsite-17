+++
title      = "Sito per portfolio fotografico: un nuovo progetto"
date       = "2014-01-30T14:21:36+01:00"
type       = "article"
tags       = [ "Programmazione", "Haskell", "Hakyll", "Foundation", "Fotografia" ]
slug       = "sito-per-portfolio-fotografico-un-nuovo-progetto"
+++

Sto iniziando un nuovo progetto per creare un sito web per un portfolio fotografico
e voglio documentare i suoi progressi in una serie di post. Li scriverò come mio
riferimento personale, ma sarei contento se fossero utili per qualcun altro.

Il primo post è sulle motivazioni del progetto e sul piano iniziale.

<!--more-->
## Perchè un sito per portfolio fotografico?
Per me la fotografia è un passatempo. Ma mi piace condividere il mio lavoro
ed eventualmente ricevere commenti su di esso. Questi sentimenti sono così
comuni che il web è inondato con immagini di ogni tipo di fotografi e non.

Condividere le tue foto non è mai stato così facile. Puoi condividerle
gratuitamente sui _social media_ (Facebook, Google+, Flickr, Instagram, ecc.)
o, ad un prezzo iniziale basso, con soluzioni più professionali 
(SmugMug, zenfolio, ecc.).

Ma... non esistono pasti gratis.

Se condividi sui _social media_ consenti a perdere il controllo di come e con
quali altri servizi on-line le tue foto siano utilizzate (leggi pubblicità).
Le regole possono cambiare con breve preavviso per motivi legati agli obiettivi
aziendali, e potresti non condividere questi cambiamenti. Per esempio vedi il
recente cambiamento di Flickr: alcuni utenti lo amano, altri non lo possono
sopportare.

Non ci sono questi problemi se condividi le foto con un sito professionale,
dato la loro focalizzazione sui bisogni dei fotografi. Ma il loro servizio
base è normalmente limitato in spazio, numero di foto, o in altre funzionalità.
Se vuoi avere di più devi pagare di più. Mentre questo ha senso per fotografi
professionali o semi-professionali che guadagnano dalle loro foto, può
essere un problema per molti fotografi amatoriali.

Ho usato alcuni di questi servici e continuerò ad usarli, per la visibilità
che possono dare alle mie foto.
Ma voglio una base stabile per mostrare le mie foto come ritengo più opportuno.
Una base che sia relativamente economica da creare e da mantenere e che non
cambi in base alla volontà di qualcun altro.

Penso che l'unica soluzione a lungo termine è avere il mio sito web ed il mio
dominio (per un'analisi approfondita sui fotografi e sul web vedi
[l'articolo di Dan Heller](http://www.danheller.com/photo-biz.html)).

Avrei potuto partire velocemente con una installazione WordPress e un tema
specializzato o con qualche tipo di software per costruire siti.
Ho deciso invece di seguire una via "fai da te": costruire un sito web
statico. In questo modo posso personalizzare il sito secondo le mie necessità
e posso iniziare in piccolo (meno costi iniziali) evolvendolo gradualmente.
È impegnativo, ma può essere divertente e sarei in grado di seguire i miei
interessi informatici e artistici allo stesso tempo.

## Come lo costruirò?
Quando inizi un progetto dove non hai una buona conoscenza della tecnologia
coinvolta, è meglio fare qualche scelta iniziale, costruire qualcosa per
verificare la scelta, cambiare quello che non ha funzionato, ripetere il processo.
Queste sono le mie scelte iniziali.

L'_hosting_ del sito sarà su [NearlyFreeSpeech.NET](https://www.nearlyfreespeech.net/).
Il sito che stai leggendo è in _hosting_ lì e non ho mai avuto un problema.
Inoltre le tariffe "paghi quello che usi" sono perfetto per le mie necessità.

Userò [Hakyll](http://jaspervdj.be/hakyll/) come generatore di siti statici.
Vorrei studiare meglio  [Haskell](http://www.haskell.org/) e penso che sia un buon modo.
Spero che sarà flessibile abbastanza per creare un sito di portfolio.
[Octopress](http://octopress.org/), il generato di siti statici che uso per questo sito
è più orientato verso siti di blog personali. Se avessi scelto di rimanere nell'ambito
_ruby_ probabilmente mi sarei orientato verso [nanoc](http://nanoc.ws/).

Voglio progettare un sito _mobile first_, ma non ho molta esperienza con CSS.
Così userò un _framework_ CSS, e per questo ho scelto [Foundation](http://foundation.zurb.com/).
Penso che sia un _framework_ facile da usare e le sue funzionalità per gestire
le immagini in modo progressivo sono interessanti per un sito fotografico.

## Quali sono i prossimi passi?
Il mio piano è relativamente semplice. I primi passi del progetto sono:

* impostare una struttura base di progetto su github con Hakyll e Foundation configurati per generare un sito web minimale (solo una _home page_)
* fare un prototipo del sito web che le pagine principali e la navigazione, ma senza foto reali
* scegliere alcune foto campione dal mio archivio e aggiungerle al prototipo

A questo punto spero che avrò una visione chiara di dove andare con il progetto
e capire se le mie scelte iniziali sono valide.
