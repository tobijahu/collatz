# Collatz Conjecture visualizations

This repo ships two implementations of the algorithm that is the foundation of the Collatz conjecture. The standard implementation only supports _double_ integers and therefor can easily be used for data analysis with standard _R_ tools. The other implementation supports large integers, but is limited in applications or (easy) further processing. 

## What is the Collatz conjecture?
The Collatz conjecture states that every natural number will eventually reach _1_ under the iteration that each even resulting number is devided by _2_, while each odd is multiplied by _3_ and then _1_ added.
It is also known as the `3x+1`-problem.

You may find more introduction and references about this at the [The Collatz conjecture](http://www.youtube.com/watch?v=5mFpVDpKX70) video by David Eisenbud on Youtube.

## Content
By running for example
`sh run_script.sh 50`
the content for iterations up to _50_ can be created. The output is put to the **output** folder. 

### .dot digraph
The following digraph includes all iterations of numbers from _1_ to _5_.
![alt text](https://raw.githubusercontent.com/tobijahu/collatz/master/output/collatz-tree-5.png "Digraph/tree of all iteration steps for numbers from 1 to 5")

### Iteration steps comparison
The algorithm on that the Collatz conjecture is founded on converges super fast for some numbers and slower for others. The following plot compares the slowest converging number among the numbers from _1_ to _50_ with the next larger power of _2_. Here _27_ has maximum steps among the numbers from _1_ to _50_ and _32_ is the first power of _2_ that is larger than _27_.
![alt text](https://raw.githubusercontent.com/tobijahu/collatz/master/output/iteration-steps-comparison-50.png "Fast vs slow converging series of algorithm steps")
Why choosing powers of _2_? For the algorithm the only way to return a number, that is smaller than the corresponding input, is by putting a number that has a factorization including factor _2_. In this sense _32_ has such a factorization, since `32=2*2*2*2*2`. In contrast to that _2_ is not a factor of _27_ since `27=3*3*3`. For _27_ the algorithm reaches _1_ after _111_ iterations. For _32_ the algorithm only takes _5_ steps to reach _1_, since in this case each iteration eliminates a factor _2_. By design of the algorithm there cannot be any number that is larger than _32_ _and_ requires fewer steps to reach _1_.

### Iteration of large numbers
#### Mersenne #9
_2305843009213693951_ counts _19_ digits and therefor cannot be processed as 64bit number, which counts less than _16_ digits. For Mersenne #9 the algorithm reaches _1_ after **860** steps. Those are

``2305843009213693951 6917529027641081854 3458764513820540927 10376293541461622782 5188146770730811391 15564440312192434174 7782220156096217087 23346660468288651262 11673330234144325631 35019990702432976894 17509995351216488447 52529986053649465342 26264993026824732671 78794979080474198014 39397489540237099007 118192468620711297022 59096234310355648511 177288702931066945534 88644351465533472767 265933054396600418302 132966527198300209151 398899581594900627454 199449790797450313727 598349372392350941182 299174686196175470591 897524058588526411774 448762029294263205887 1346286087882789617662 673143043941394808831 2019429131824184426494 1009714565912092213247 3029143697736276639742 1514571848868138319871 4543715546604414959614 2271857773302207479807 6815573319906622439422 3407786659953311219711 10223359979859933659134 5111679989929966829567 15335039969789900488702 7667519984894950244351 23002559954684850733054 11501279977342425366527 34503839932027276099582 17251919966013638049791 51755759898040914149374 25877879949020457074687 77633639847061371224062 38816819923530685612031 116450459770592056836094 58225229885296028418047 174675689655888085254142 87337844827944042627071 262013534483832127881214 131006767241916063940607 393020301725748191821822 196510150862874095910911 589530452588622287732734 294765226294311143866367 884295678882933431599102 442147839441466715799551 1326443518324400147398654 663221759162200073699327 1989665277486600221097982 994832638743300110548991 2984497916229900331646974 1492248958114950165823487 4476746874344850497470462 2238373437172425248735231 6715120311517275746205694 3357560155758637873102847 10072680467275913619308542 5036340233637956809654271 15109020700913870428962814 7554510350456935214481407 22663531051370805643444222 11331765525685402821722111 33995296577056208465166334 16997648288528104232583167 50992944865584312697749502 25496472432792156348874751 76489417298376469046624254 38244708649188234523312127 114734125947564703569936382 57367062973782351784968191 172101188921347055354904574 86050594460673527677452287 258151783382020583032356862 129075891691010291516178431 387227675073030874548535294 193613837536515437274267647 580841512609546311822802942 290420756304773155911401471 871262268914319467734204414 435631134457159733867102207 1306893403371479201601306622 653446701685739600800653311 1960340105057218802401959934 980170052528609401200979967 2940510157585828203602939902 1470255078792914101801469951 4410765236378742305404409854 2205382618189371152702204927 6616147854568113458106614782 3308073927284056729053307391 9924221781852170187159922174 4962110890926085093579961087 14886332672778255280739883262 7443166336389127640369941631 22329499009167382921109824894 11164749504583691460554912447 33494248513751074381664737342 16747124256875537190832368671 50241372770626611572497106014 25120686385313305786248553007 75362059155939917358745659022 37681029577969958679372829511 113043088733909876038118488534 56521544366954938019059244267 169564633100864814057177732802 84782316550432407028588866401 254346949651297221085766599204 127173474825648610542883299602 63586737412824305271441649801 190760212238472915814324949404 95380106119236457907162474702 47690053059618228953581237351 143070159178854686860743712054 71535079589427343430371856027 214605238768282030291115568082 107302619384141015145557784041 321907858152423045436673352124 160953929076211522718336676062 80476964538105761359168338031 241430893614317284077505014094 120715446807158642038752507047 362146340421475926116257521142 181073170210737963058128760571 543219510632213889174386281714 271609755316106944587193140857 814829265948320833761579422572 407414632974160416880789711286 203707316487080208440394855643 611121949461240625321184566930 305560974730620312660592283465 916682924191860937981776850396 458341462095930468990888425198 229170731047965234495444212599 687512193143895703486332637798 343756096571947851743166318899 1031268289715843555229498956698 515634144857921777614749478349 1546902434573765332844248435048 773451217286882666422124217524 386725608643441333211062108762 193362804321720666605531054381 580088412965161999816593163144 290044206482580999908296581572 145022103241290499954148290786 72511051620645249977074145393 217533154861935749931222436180 108766577430967874965611218090 54383288715483937482805609045 163149866146451812448416827136 81574933073225906224208413568 40787466536612953112104206784 20393733268306476556052103392 10196866634153238278026051696 5098433317076619139013025848 2549216658538309569506512924 1274608329269154784753256462 637304164634577392376628231 1911912493903732177129884694 955956246951866088564942347 2867868740855598265694827042 1433934370427799132847413521 4301803111283397398542240564 2150901555641698699271120282 1075450777820849349635560141 3226352333462548048906680424 1613176166731274024453340212 806588083365637012226670106 403294041682818506113335053 1209882125048455518340005160 604941062524227759170002580 302470531262113879585001290 151235265631056939792500645 453705796893170819377501936 226852898446585409688750968 113426449223292704844375484 56713224611646352422187742 28356612305823176211093871 85069836917469528633281614 42534918458734764316640807 127604755376204292949922422 63802377688102146474961211 191407133064306439424883634 95703566532153219712441817 287110699596459659137325452 143555349798229829568662726 71777674899114914784331363 215333024697344744352994090 107666512348672372176497045 322999537046017116529491136 161499768523008558264745568 80749884261504279132372784 40374942130752139566186392 20187471065376069783093196 10093735532688034891546598 5046867766344017445773299 15140603299032052337319898 7570301649516026168659949 22710904948548078505979848 11355452474274039252989924 5677726237137019626494962 2838863118568509813247481 8516589355705529439742444 4258294677852764719871222 2129147338926382359935611 6387442016779147079806834 3193721008389573539903417 9581163025168720619710252 4790581512584360309855126 2395290756292180154927563 7185872268876540464782690 3592936134438270232391345 10778808403314810697174036 5389404201657405348587018 2694702100828702674293509 8084106302486108022880528 4042053151243054011440264 2021026575621527005720132 1010513287810763502860066 505256643905381751430033 1515769931716145254290100 757884965858072627145050 378942482929036313572525 1136827448787108940717576 568413724393554470358788 284206862196777235179394 142103431098388617589697 426310293295165852769092 213155146647582926384546 106577573323791463192273 319732719971374389576820 159866359985687194788410 79933179992843597394205 239799539978530792182616 119899769989265396091308 59949884994632698045654 29974942497316349022827 89924827491949047068482 44962413745974523534241 134887241237923570602724 67443620618961785301362 33721810309480892650681 101165430928442677952044 50582715464221338976022 25291357732110669488011 75874073196332008464034 37937036598166004232017 113811109794498012696052 56905554897249006348026 28452777448624503174013 85358332345873509522040 42679166172936754761020 21339583086468377380510 10669791543234188690255 32009374629702566070766 16004687314851283035383 48014061944553849106150 24007030972276924553075 72021092916830773659226 36010546458415386829613 108031639375246160488840 54015819687623080244420 27007909843811540122210 13503954921905770061105 40511864765717310183316 20255932382858655091658 10127966191429327545829 30383898574287982637488 15191949287143991318744 7595974643571995659372 3797987321785997829686 1898993660892998914843 5696980982678996744530 2848490491339498372265 8545471474018495116796 4272735737009247558398 2136367868504623779199 6409103605513871337598 3204551802756935668799 9613655408270807006398 4806827704135403503199 14420483112406210509598 7210241556203105254799 21630724668609315764398 10815362334304657882199 32446087002913973646598 16223043501456986823299 48669130504370960469898 24334565252185480234949 73003695756556440704848 36501847878278220352424 18250923939139110176212 9125461969569555088106 4562730984784777544053 13688192954354332632160 6844096477177166316080 3422048238588583158040 1711024119294291579020 855512059647145789510 427756029823572894755 1283268089470718684266 641634044735359342133 1924902134206078026400 962451067103039013200 481225533551519506600 240612766775759753300 120306383387879876650 60153191693939938325 180459575081819814976 90229787540909907488 45114893770454953744 22557446885227476872 11278723442613738436 5639361721306869218 2819680860653434609 8459042581960303828 4229521290980151914 2114760645490075957 6344281936470227872 3172140968235113936 1586070484117556968 793035242058778484 396517621029389242 198258810514694621 594776431544083864 297388215772041932 148694107886020966 74347053943010483 223041161829031450 111520580914515725 334561742743547176 167280871371773588 83640435685886794 41820217842943397 125460653528830192 62730326764415096 31365163382207548 15682581691103774 7841290845551887 23523872536655662 11761936268327831 35285808804983494 17642904402491747 52928713207475242 26464356603737621 79393069811212864 39696534905606432 19848267452803216 9924133726401608 4962066863200804 2481033431600402 1240516715800201 3721550147400604 1860775073700302 930387536850151 2791162610550454 1395581305275227 4186743915825682 2093371957912841 6280115873738524 3140057936869262 1570028968434631 4710086905303894 2355043452651947 7065130357955842 3532565178977921 10597695536933764 5298847768466882 2649423884233441 7948271652700324 3974135826350162 1987067913175081 5961203739525244 2980601869762622 1490300934881311 4470902804643934 2235451402321967 6706354206965902 3353177103482951 10059531310448854 5029765655224427 15089296965673282 7544648482836641 22633945448509924 11316972724254962 5658486362127481 16975459086382444 8487729543191222 4243864771595611 12731594314786834 6365797157393417 19097391472180252 9548695736090126 4774347868045063 14323043604135190 7161521802067595 21484565406202786 10742282703101393 32226848109304180 16113424054652090 8056712027326045 24170136081978136 12085068040989068 6042534020494534 3021267010247267 9063801030741802 4531900515370901 13595701546112704 6797850773056352 3398925386528176 1699462693264088 849731346632044 424865673316022 212432836658011 637298509974034 318649254987017 955947764961052 477973882480526 238986941240263 716960823720790 358480411860395 1075441235581186 537720617790593 1613161853371780 806580926685890 403290463342945 1209871390028836 604935695014418 302467847507209 907403542521628 453701771260814 226850885630407 680552656891222 340276328445611 1020828985336834 510414492668417 1531243478005252 765621739002626 382810869501313 1148432608503940 574216304251970 287108152125985 861324456377956 430662228188978 215331114094489 645993342283468 322996671141734 161498335570867 484495006712602 242247503356301 726742510068904 363371255034452 181685627517226 90842813758613 272528441275840 136264220637920 68132110318960 34066055159480 17033027579740 8516513789870 4258256894935 12774770684806 6387385342403 19162156027210 9581078013605 28743234040816 14371617020408 7185808510204 3592904255102 1796452127551 5389356382654 2694678191327 8084034573982 4042017286991 12126051860974 6063025930487 18189077791462 9094538895731 27283616687194 13641808343597 40925425030792 20462712515396 10231356257698 5115678128849 15347034386548 7673517193274 3836758596637 11510275789912 5755137894956 2877568947478 1438784473739 4316353421218 2158176710609 6474530131828 3237265065914 1618632532957 4855897598872 2427948799436 1213974399718 606987199859 1820961599578 910480799789 2731442399368 1365721199684 682860599842 341430299921 1024290899764 512145449882 256072724941 768218174824 384109087412 192054543706 96027271853 288081815560 144040907780 72020453890 36010226945 108030680836 54015340418 27007670209 81023010628 40511505314 20255752657 60767257972 30383628986 15191814493 45575443480 22787721740 11393860870 5696930435 17090791306 8545395653 25636186960 12818093480 6409046740 3204523370 1602261685 4806785056 2403392528 1201696264 600848132 300424066 150212033 450636100 225318050 112659025 337977076 168988538 84494269 253482808 126741404 63370702 31685351 95056054 47528027 142584082 71292041 213876124 106938062 53469031 160407094 80203547 240610642 120305321 360915964 180457982 90228991 270686974 135343487 406030462 203015231 609045694 304522847 913568542 456784271 1370352814 685176407 2055529222 1027764611 3083293834 1541646917 4624940752 2312470376 1156235188 578117594 289058797 867176392 433588196 216794098 108397049 325191148 162595574 81297787 243893362 121946681 365840044 182920022 91460011 274380034 137190017 411570052 205785026 102892513 308677540 154338770 77169385 231508156 115754078 57877039 173631118 86815559 260446678 130223339 390670018 195335009 586005028 293002514 146501257 439503772 219751886 109875943 329627830 164813915 494441746 247220873 741662620 370831310 185415655 556246966 278123483 834370450 417185225 1251555676 625777838 312888919 938666758 469333379 1408000138 704000069 2112000208 1056000104 528000052 264000026 132000013 396000040 198000020 99000010 49500005 148500016 74250008 37125004 18562502 9281251 27843754 13921877 41765632 20882816 10441408 5220704 2610352 1305176 652588 326294 163147 489442 244721 734164 367082 183541 550624 275312 137656 68828 34414 17207 51622 25811 77434 38717 116152 58076 29038 14519 43558 21779 65338 32669 98008 49004 24502 12251 36754 18377 55132 27566 13783 41350 20675 62026 31013 93040 46520 23260 11630 5815 17446 8723 26170 13085 39256 19628 9814 4907 14722 7361 22084 11042 5521 16564 8282 4141 12424 6212 3106 1553 4660 2330 1165 3496 1748 874 437 1312 656 328 164 82 41 124 62 31 94 47 142 71 214 107 322 161 484 242 121 364 182 91 274 137 412 206 103 310 155 466 233 700 350 175 526 263 790 395 1186 593 1780 890 445 1336 668 334 167 502 251 754 377 1132 566 283 850 425 1276 638 319 958 479 1438 719 2158 1079 3238 1619 4858 2429 7288 3644 1822 911 2734 1367 4102 2051 6154 3077 9232 4616 2308 1154 577 1732 866 433 1300 650 325 976 488 244 122 61 184 92 46 23 70 35 106 53 160 80 40 20 10 5 16 8 4 2 1``

#### Mersenne #20
_285542542228279613901563566102164008326164238644702889199247456602284400390600653875954571505539843239754513915896150297878399377056071435169747221107988791198200988477531339214282772016059009904586686254989084815735422480409022344297588352526004383890632616124076317387416881148592486188361873904175783145696016919574390765598280188599035578448591077683677175520434074287726578006266759615970759521327828555662781678385691581844436444812511562428136742490459363212810180276096088111401003377570363545725120924073646921576797146199387619296560302680261790118132925012323046444438622308877924609373773012481681672424493674474488537770155783006880852648161513067144814790288366664062257274665275787127374649231096375001170901890786263324619578795731425693805073056119677580338084333381987500902968831935913095269821311141322393356490178488728982288156282600813831296143663845945431144043753821542871277745606447858564159213328443580206422714694913091762716447041689678070096773590429808909616750452927258000843500344831628297089902728649981994387647234574276263729694848304750917174186181130688518792748622612293341368928056634384466646326572476167275660839105650528975713899320211121495795311427946254553305387067821067601768750977866100460014602138408448021225053689054793742003095722096732954750721718115531871310231057902608580607_ is the Mersenne prime #20. It has _1332_ digits. To reach _1_, the algorithm takes ??? steps.
