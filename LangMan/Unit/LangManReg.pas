//*****************************************************************************
//**  LangMan -  Localization components package for Delphi                  **
//*****************************************************************************
//**                                                                         **
//**  File:      LangManReg.pas                                              **
//**                                                                         **
//**  Version:   2.6.6                                                       **
//**                                                                         **
//**  Date:      2016-05-11                                                  **
//**                                                                         **
//**  Author:    Ing. Tomas Halabala - REGULACE.ORG                          **
//**                                                                         **
//**  Notice:    This components set is free for personal use only.          **
//**             Comercial use is not allowed without author permission!     **
//**                                                                         **
//**             It is not permitted to use these components in application  **
//**             published under a different publisher name than what is     **
//**             registered with this copy. Transferring the license to      **
//**             another person or company is not possible.                  **
//**                                                                         **
//**             It is prohibited the distribution of any part or whole      **
//**             source code and use part or whole source code for           **
//**             the creation and distribution of any other component,       **
//**             distributed with or without source code.                    **
//**                                                                         **
//**  Licensee:  denis kakop                                                 **
//**                                                                         **
//**  Disclaimer:THIS SOFTWARE AND ANY RELATED DOCUMENTATION IS PROVIDED     **
//**             "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED      **
//**             OR IMPLIED INCLUDING BUT NOT LIMITED TO THE APPLIED         **
//**             WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR     **
//**             PURPOSE, OR NONINFRINGEMENT. AUTHOR DOES NOT WARRANT,       **
//**             GUARANTEE, OR MAKE ANY REPRESENTATIONS REGARDING THE USE,   **
//**             OR THE RESULTS OF THE USE, OF THE SOFTWARE IN TERMS OF      **
//**             CORRECTNESS, ACCURACY, RELIABILITY, OR OTHERWISE.           **
//**             THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE           **
//**             OF THE SOFTWARE REMAINS WITH YOU.                           **
//**                                                                         **
//**  Copyright: Copyright (c) 2009-2016 Ing.Tomas Halabala                  **
//**                                                                         **
//**  E-mail:    tomas.halabala@regulace.org                                 **
//**                                                                         **
//**  Website:   http://www.regulace.org                                     **
//**                                                                         **
//*****************************************************************************

unit LangManReg;

{$INCLUDE LM_Config.inc}
{$DEFINE LMREG}
{$DEFINE LMREGIDE}

interface

{$IFDEF WIN32}

uses Classes, Designintf, DesignEditors, ToolsAPI, LangManCore;

type
  TDefaultLanguageProperty = class (TStringProperty)
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TLangISOCodeEditor = class (TStringProperty)
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  LangManTagEditor = class (TIntegerProperty)
  private
    function EditorDisabled(Component: TPersistent): Boolean;
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  LexiconEditor = class (TComponentEditor)
  public
    procedure Edit; override;
  end;

  TNameProperty = class (TComponentNameProperty)
    procedure SetValue(const Value: string); override;
  end;

  TLMEngineHelper = class helper for TLangManCore
  public
    procedure DesignTimeMode(Project: IOTAProject);
    function EditorAllowed(Project: IOTAProject): Boolean;
  end;

const he  =  'BM7.(.!,&+.!)&*0!)&$()0!,&()"*&)0!(&4((.!(&$()+#((3!G&!)*/!(*.#**-"**/!)*.")*/")*.*/*.),!()*!(*,#(*+*-*,!)*0!)*1!)*/!(*1*0!)*1!>&:980-0)~2)#(13"(10"(2(2-163)2321333.3,34303-37333134303-2724222*1613272/2)3-242.35#(3+263425!>&yog535/5.6,55' +
             '5363$(6-6+646/616,6*525,5*44404+#(47"(42!(4.5-46426/6)5661"(6*57#(53516*503(2523!>&<+)*/!(6*6+6-6)6(626/6.7(66656763626*5553444/4+5)43406+55535.5)45424-4)5/5,5)55525/6,6(55!A&gK+*5(3/2-!(7/71707-7,!)7771!(7/626,6*5,4745515.5,646/6-717/7.' +
             '7,!(7*616.6,6/6+6)<;:!;&kP++3/y<3*a).2*V)0575(40!(7075!)77!(7477"(6664352/1/5*373(!(7/"(70727/!(7776!)7701000/!8&qZ++5*2)c34q*-4506<5016G5)1*=431.T676(4,7*#(6*4.7,376.5-313314~2.wT62565.!,77474544!8&k$(P*344"(1,5)9522(A7(43t7*5(0(7/541.#' +
             '(716+2(613*7/6.24706-2,#(7,"(6(3+3/40251)17hA432/036+6(56!(*4*5!5&y]*76,#(4*0,6.0+7-562.726235#(767/507157#,777254736("*7766!(747072"(6445503021"(1-03L).zT+,!5&3417e7)6,3.#(77715(725-767/5)757-44747)4,#(757+427.5+#*77"(7354577763746576"(' +
             '7366675*625/343*222316~o2)S)2!5&77735)7)5-1,522/Q5520N6134d#(664+e4)d#(674.s4,q7+45/77,42r7(5+2)7+6/5*7/61#(457*6,5+404*3+151/2//7e10D(.3503L201*^w]+)!,&4225o4,0+;20W(535p 5011F6130`#(6."(27[`6331q6)2)Z6,15Q542-p5/44426(5-4656"(5*434)3+4' +
             '106K40~*)5(1-<7)5-02!(7762777+42!,&eI*,23_**20X)+35i),450**55/1+@521-G5411N6+2._6*2+c6-331,604/2)62$(534,67617-645*706-2474653)756420777(3)73674(6*441004o<!/&3,k*4#(34g)+_(-42z**5,02+*5513D6+24i66462.7/625/74706.#*777/5)736*716(7*4676634' +
             '*7/5/156*24]4-}*0350+I!5&5/2,f4-s)/470-*.6-3+b7.521/#(76653-7161737(5-71552+7-5+12665*207(432(#(7*4*04350-67320,6/21m511*N4-o)630v=!2&YE*-7*5625716,2+777-31736.2*675-156*5,4,525)475/3723542.r57260+6*311.6225r#(6327v#(3(w60x6(2)c5,07K4*m)' +
             '23(x>!2&716234!(776.7*5-1*5,07+(4+y*.342,104)3,3/403334474-4/$(5.45$(5(54516(4/6*2/n#(6+2(\2)a5716^5/06E43~+.37j)-331-]!2&7/6.27757)4+5625j33_(,3,r=3/253,37!(3(4-3/3043!(375(!(4-5+4.4+5.44465-34245/13b501.U5,04G43|+)4(h),400(+(6344012/00' +
             'M!5&4(210+4.0/F250.p3,2-2032!(23373(3)4-$(3/"(304.4-262-423332454-41403-274.170*5(1/X5514A5417@6(35~3*1*T\E*)!8&464-37#(23132)12143,2+2,31!(2134273)4(2-104/12#(r"(5(2+4(315,36245/21p5117J523.x453({!D&4)3-$(2.3+151/1*1+2512133*!(2)3.06t33' +
             '}E4,00K33171(#(3504_l)/3(07{"(202,!J&1(0/w4.3)2*3-1,/7260)b200.u2,020/22/7h27}X3*0+`351703~zy!S&vm_2,1+}322-1*302/163,2+101-0.vhc\!!5&';

      par =  'BM+.)3!,&+.!)&*0!)&$(+(!,&()"*&)0!)&)3!(&$()+#((3!2&!"(42(!,n!,0,0)#(0(#(/70*~}{ywuv$(tr#(z"(w")|}|!){!(zh!(gJ!(IG!(Ec!(b!)1-0(!(/7!)z!)usr!(q!(p!)o!,l!)o!,q!,0,!)u!S2(!)*4!)*0!) !2)6!/**!)*)!) !)*-!)*2#(*/*.!(*-***4*1#(*."**2*0"(*2#-*3!' +
             ')*4#)*3!(*4!**3!+*2!**1#(*2!(*1*2*1!(*5*4!)0,!S2(!)*2!(0*/70.0)|t"(nji")ch[]U#(^W"(QVe]Uph`~uo020){101)032,1712262523202/2.2*2(!(16101+0-~!(vogn"(f!(^UaYPd[R$(g^Uo]zqh00/7w11070027202)3,232,!)0,!Y2(5.4643565-5)6*525/6-$(555160#(57"(636*6' +
             ',6)$(636/6+7(617+!(6770!(7-77!(747/!(7+6*56535/5)46636/6.74!(7077!(7572!(7.7-7(!(66616.#(626,6)6("(556-516*52"(5/575,535*47#(5."(45!(41313(24!Y2(!(42415-47#)445/465047525)46565-5*6*515.6-5552606+6(7)63617+6766626,6+5)43404+373242"(4-4(4)' +
             '33444/4+36323-45414-6+5653646/6,62"(6.#(6+6(56525/555,5)5047445,434/5*40#(4-#(5(415/45525,5)!\2(565452616.6-7)67667-!(7*#(7.7,!(7+7)7+7(66616-6,535/5,424,"(4(4/345)43405(45$(4/43404+4,3647$(43405+46313+263,232.333-26434,37555-5+6/6+6)#(6' +
             '3606-"(61!(6.6,6.6+6)6(52506-6)56!_2(5(45424+34304.4)36404+4(424.4*#(44"(40!(4,5)454353505.626/#(6.65615753505)444143"(4/4*4,365,4541565/5,6)54514/"(4)35313,454.4*4640$(4-4/4+374)344/4*35404+37434-4)525-5*!b2(5(4543737/707*66657($(64637*' +
             '6572707/!,777674737-7+7)636/6-6)54515+4644434/4*404,4(5/5*4757525.616-6*7)6564505-5*4)3430424-4)5653527(67667.7-!(7,7*!(7)65636,6)6(!e2(7/!(7+7)!(65#(7("(6462637.7+7*#(76!*747371707-7+7*6662616,5754525*474440#(4+454/545.5+6+5653636.6,7*!' +
             '(667371!(707/7.5653514+36313,"(262.2/2)202*13404+35!b2(4.1/m30{G4-2.05!(7,7/#(7("(64!(637-7*7($(74!(72777573!(717/7-7,7(64636.6)56545-5*45414,5(424/6(53506/6*6(6762617,7)7(7/7.7,73!(71!,7775!(747+!(7(717.7,!\2(3113y512(j4.0)E20Y)311C(+04' +
             '>(05.4+3.!(7/707+66647,7)6772!(7077!)75!(73717.7-7+6766616,6)565250#(5*46424441$(6.6(56626,7*66657.7,7+71!(7/74!(72#(76!(75!(74717/7.76!(72!\2(552+l40}++36y*53(c)/2.R#((-21U2*N(+2,h+-646,577.7,!(7+676571!(7.77!(7576!(7472707/7-7*7)67!(63' +
             '56!(5220}^21wO$(63!(6067627,7)7(707.7-73!(71#(76!(74!(7573!(71727/7.6*5756!V2(634(0-4306O21V(525b)44-0++*440494.0)*35+10O4303B22_)/3407h7,")7+707)"(717/!,777372767-7)67575-4326171.1*iO04<(+4-2-067273767.7,7+72707.757372#(76"(747574717/7.' +
             '767271!V2(644,05553)t37z*33,k**36~+-5)1+:6+3.o542)F6-3,f5724]470794+/7*06*4-1.7)6+43676(4266554.#(67523/5-2-605)256(4-14544*16433/2(2003w1,S*+5(302/!)77"(767576!(7377!(7574!(72767574!V2(6(3*0(#(5)10S1-B4//7*,5)1+B5621P6131\654,q6-3*P603-' +
             'Q6740s7)44x7*47w7,521+7-54077(5){6544o7+5.y7,5*s675,2*665-237(#(5/2467265/4+212003v05A(03207s7+6763!,7773$(71707572!S2(6+3,~4-0)=410/+(5.12=5+1-+.5620P654+e7-5/0-7*5(v7,5,0+716+20#(74674+6631#,777.42"(73!(507554765.745(757)3,7060307,6+33' +
             '7)543+#(7(51"(3(504634212*x[02+/&1-S*)4-170)646-57!)77!S2(7*451)5.12K5)1.?6(24I6743v644,e6743r7/561)72643173674.#*74$(7(41#(7)4.3432757-4176726(#-77746-75667772767-756574"(637372675)7*56307)533,6.5(273-2/16120,{1-N)307;&26tD!M2(4322}6,30' +
             'q71521/7+5-1*6641z7+532)706-26736433757,507670607572#(63"(7673726,#(75"(71556+76#*726,"(756.6/766+#-77746*767("+777+70$(73!(7776657.6.4,7)543166503/4*272)161/!(13xd14G(12-O(3230/d!G2(6,31s7+4-j745-{75664)747)41#(757/52726.#(76"(747(61777' +
             '4#(60"(76!(7565#.76757($)747*736362756764726-7361#-777465$(767+#)777/!(70!)777673637/60407+57366551334*3)2.2-10111605032)[*.11C(+32n+(!D2(7(4)i75520-#,77653+726-777,73557250715+76#(7-4*"(75"(34"(7+"(75357)31#)74642/"(663)3+73653.757+4.#)' +
             '76$(7/5(7-405.#*777154725,75"(6/74#)76"(726+"(6,71737*5/7.6.4/7-6+4,6-5+343527202215#(142+112)~i17R)/16L)(5)2/0*!>2(6,30q76$(6-2."(77737/5+767-45716,127)5)z65#(41q66p7)47{7(45z#(6741w40k7)42l674,i7(41q716*2-#(7,"(5*~0(736-2)#(7463276/2(7' +
             '36,1274602/#(737(5)7)5-#(71644563#)4470627/607.6.437(6(405,4-313225233(2-2/21"(2)2.1.112(Y*+1.<()31yD513,~5-27r5,26t232+1.!22(#*776/2-7*4.7+3.6.1)7(460/512+M461)=4-/7*.4400*35215=6)21K6+26#(T603-674/r#(613-Y3._674+o6331a603*\633,T7(4(g#(' +
             '7*4,j4(a6731Z6-5(3)646)5*7-6.46#)7.")6/!(475(7)6*46555(4+4.333031!(253,171/2700l20m?2+T).1/@&3/m*,7-5)02#(766+156(1,735(s6.30k!/2(7)4+n755201776/2-76603(5523b3-f))3/#(p*/33 4,}*45+1,=6*3)d6+27U664*e7,5)0)603*V6+20T6/27Z6433m6231p6,2.Y6)#' +
             '(17R"(6+P14J6+1,:522*h$(5-404*6)436154466256476.524657"(5+42"(4/4,4)4.352)1*#(3.b)1`(63+^(43*f)625](74300*3726+2)#)77"(76657+7461766(10533)p!/2(6*3-l7)4+n7-47034/0.?2)L(,20Z#().3(a3,c),4+v)75+04+(542)J603,[6436m6)2/U5414Q6-25a664+z654*0)' +
             '6-25l6)2.k6+21p6.23q6/20j6+2)_5)363)5*42"(435-41504643#(52"(5(44465.42405+4*315(2*k440(*,430-*35*1)+*5621I6.30S7*45c756417#*77652,7,4(777463"(3.6*k!/2(4+200*5,3({6.3-w26a)611D()2,X)022[)/30g)24,t 41~*44703?5210D6+22[562(Q521.K6+20^6231q6' +
             '130w6*2+^6(2(_#(6,2+b20m56301252322*544-3.555,5.565+5(6-535,636(5-6456"(40630*7(42r#(7.5/0(50#(0)7-5/726)07767(26#,77704/735-"(746/62705361207/41l4.220(!22(4+2300542,h22^ 2,V).24#(c*+30(74)k)*4/s)05(0-*55)0395,00+)52#(1,?51C5/06B521-J571' +
             '6W#(6(2+a14W6)2(]6+20k6(4.3*6-41227)4+0-#(7,5(1-6*357/6241747+46#)767.5,7+4/7)30#,77705(746)766/776.7452715.767+4,75652674674(766-2,7346j6132h4*200,!82(5.15f2.V)/21X(737r*)#(35b(/d(24.s)05+03+,5-1)A5*0.+(5/1(?5.07@5,01?5.05B5410O6*22k6/3' +
             '*n6346237($(6+5*7-6772624(766632#.777/5.736(7561")777,727-$(7665746/7-46736-137*5(t6032V6(26N5-128420.*-5+3,056/4(0-!A2(5,15i2/X)137s**4*t*)31^(.33`(/4)i))40u 440(+*5(0**5501*>5515I6*2-Q6030q665*2/7,6/5+717)6($(757470"(777.7464#)777562$(' +
             '7664746/#(726+766-#)757-5(7(4+623-746*2272532+7.5+107(4(~6,20_5(00;4(u*726Z)(20K&3/04o!D2(6*44235(13`430++*34j)23/[#((-32_4*k)*43|*)5111B6.26M7(4-e7.5.0(726,16747.6.#*77"(76727-746-#(7050766,74664(726/247/6+267-6,4)7,523(7+5-257-451/7.41' +
             '1)7-4,057+360/7(3501643+|6.2/j6(15\501)K5(01E4/s**#(33\&1)t!D2(615535563+y430-+/4,v)741|)65/1(*,6-25A7(4.`716(1-767*37#)777353"(756/#(667671747.6270604*7.5.017,460.7)4/0*67#(4)0(601,6-4(1463351(67330/#(663/}3./767#(3/"(0)66653-}643.0)602' +
             '5r6+2*c5410T5-05F460-@4,o)331Z&4+1+i!D2(6/5)2-60411,6-3-]6335V7,5+u736-1.#*777.4/7452756(7.457367407.6-337(6+476154456,525+544*216(#(16U6)[6*2)`6,2*_#(6*3-043413613+~#(64"(3-0(/765310,#(66320.310-643/0)63300.6.24s6(2*d521.S5+03F43/7+/4)i' +
             '))31](+4612a!A2(5(24u705-1(73#(7*40754(#)77725/77647553767*3.70540,7)4-^6/33i50321-5+4+31474*37454)4(474,"(4-5*4-5+3(1-#(5/2502#(210*53{5540336+26|6123o#(6024r23o#(6125"(q2460#(23"(o6/6.25u6(17`5413Z5.1)M5)07N41/7836h)-32b(65-3(0*!>2(6,3' +
             '.k755/}#*777+43"(77757,7/41716*06674+X6)2-+-5,01**40}*14(2(04373)3,4*3-3/4.!(3142!(3646!(4*5*!(4/5-465)515*5.525+5-5650536(52!(5430106+22s6.20l#)6-")2/hji#(6,2-f2.j6)2+f541/S5/1(I5*0.;440+=4,p)634d(74+0);53331(!>2(755.0*#)77736+7/5(715.7' +
             '47(32664/k5/1-+-4-v)734`(+33a(13-1+0(32#(3(3.373(4*!(3,4-!(3041!(3444!(4(47!(4,5+!(4/5.!(4351!(4754!(5*57!(5.6(546*534(24#*6)15Y"(2)`a2(_#(6(15[2*e5411V501(I5+00>460+:40|+*4(f(64)j(4573*o7(4/0+5)25t!;2($(76571/"(77677+3777"(715.64375624b' +
             '4,u**32h)230Z&3/l*23-202532232435!(264(3)3*4+3-3.4.!(3142!(3545!(4)47!(4,5+!(4/5.!(4450!(4752!(5(55!(5-#(50!(4517k561/Q5712U5610#(S541/5313]5.07G5+00?46/7+*420(94+o)532\(*40~*07)5-13766+2,7145x5.27u!82(7+4+k#)776,147)4,673772644,6+340)44' +
             '0/:4(o)532c(63.f 3,2+2-30!(2132232436!(264)3*3+4+3.3/4.!(3143!(3544!(4(474,4-5(4(#(34"(5*4)4.4,5*4-4+5-43445*4.4,5(2+|5-1+S5+1.\#(5/1+P06F5)0++/45~+)41z*64,u*335#(a(133(05-2)_7-470/765.w776.226/31l!;2(6(3+m7(37f6333e65451.605)2/5-16]40{*' +
             '137l)13(k++27121/3.2.2/30!(2132!(2336!(264)3*3+4+!(3.4/!(3141!(34#(42!(363.244.221341241144343/45!(4*5)4/4145!(4+#(4/3.3*2*01451/f#(4-1+k02V45}*3#)430,8{)5z)+5014G7(5)1.715(0)76531)725)0,5/3(t!G2(60554)6(3300451)M3.}L211,1+2615163+!(2*3.' +
             '2-2.30212233!(2436!(264)!(3*4+!(3-4-30314,3.3-4)2*1(4+2-1,4036"(4(434*44!(4(43!(374135374-252*4+10w#(4-14}2*0-5.1,@562-N6,3)Y6-3(O6030\7+532,72501.7/43{6736l5-26t!M2(676/5.443/$(21231/1.101225131427162(3*2*2)3.!(2-3/!(2032232434!(2537!(3' +
             '(4)3*3+4+3/324,344*4-37!(403*2/4016|4235"(364533474)355(4(325*4.4+5,4(25532-Z6/25I7)42w7*40j674.m665)1.7*5(11533)p4724x!V2("(7(654-313423!(11211.1/2412132616173*!(2)3-!(2,3.!(2/30212232!(24342526352-1137130+4+1)e5(05@5/10I463/2.5*4-4*504' +
             ',3+5/4+3*52311*572(B541.+)5117L5-3(~5*21r543*q6.4314!b2(636+534.3132241317201.102312142715173)2(2)3+!(2+3-2-2.#(3/21222,2)35u+,4+k)+4/s)45(01+-5,2)c403)2+4/262(4110e401*X440(*/43w),4)z*63)1*0*26152)4*3+3-6)5655!h2(62544)5*342/3+151121#(1' +
             ')042.1*21!(1.25131426162(3)!(2)3+2,2.#(3*121,0+a27#(0,g3/Z4)x*63(/7[#(3*1.022,21250/s30#(l*.34)5#(2/z_11174/34356*5650!n2(60513453413,4(2115221,1)2-040/2/!(1)250(b26$(uH21#(0.271+250-n221*07271)0/26xP2100{3(07}3+zI31c)+30l*,3(~Z3.2126525' +
             '+5)53505*!t2(5,44326-"(5/!(4)224+2/1)311/|3/#(0,W25k220*j2.#(~i2/g2,0/0)2-0504220,n32|D3-q+-23zW3(1)0*332/2)5*4143606*57!!)2(5,44326,5-346*412-5-321145220,4+16|3-11013(1-03251/1,2714"(123)1*31$(13004(204331255-4137535*4+!!82(5.4534575,35' +
             '6(5)305241315/#(4.3/503,5-4-30524231545)35515(36!"(F2(';


procedure LangManEditor(Component: TComponent);
procedure Register;

{$ENDIF}

implementation

{$IFDEF WIN32}

uses 
{$IFDEF DXE2}
     Winapi.Windows, Vcl.Forms, Vcl.Dialogs, Vcl.Graphics,
     System.UITypes, System.TypInfo, Vcl.Controls,
{$ELSE}
     Windows, Forms, Dialogs, Graphics, TypInfo, Controls,
{$ENDIF}
     SysUtils, LangManSys, LangManCtrls, LangManComp, LangManDlg, LangManISO;

var EngineAdjustID: Integer;

function GetApplicationDeploymentPath(DT_Project: IOTAProject): String;
begin
{$IF CompilerVersion < 17}
  Result := ExtractFilePath(DT_Project.FileName);
{$ELSE}
  Result := ExtractFilePath(DT_Project.ProjectOptions.TargetName);
{$IFEND}
end;

procedure TLMEngineHelper.DesignTimeMode(Project: IOTAProject);
begin
  if DesignTime AND (Project <> nil) then begin
    _ProjectPath := GetApplicationDeploymentPath(Project);
    FindLangFiles;
  end;
end;

function TLMEngineHelper.EditorAllowed(Project: IOTAProject): Boolean;
begin
  DesignTimeMode(Project);
  Result := EditorCanBeShown;
end;

{$IF CompilerVersion > 16}
{$IFDEF LMULT}
{$I LMInline}
{$ENDIF}
{$INCLUDE LM_Config.inc}
{$IFEND}
{$IFDEF LMDESI}
{$I LMDesigner}
{$ELSE}
procedure LangManEditor(Component: TComponent);
begin
  ShowMessage('Language Editor at design time is not available under this LangMan edition.' +
              #13#10 + 'Please upgrade your license.');
end;
{$ENDIF}

//+****************************************************************************
//+*  LangMan Component Property editor                                      **
//+****************************************************************************

function TDefaultLanguageProperty.GetAttributes: TPropertyAttributes;
begin
{$IF CompilerVersion > 19}
  Result := [paValueList, paValueEditable];
{$ELSE}
  Result := [paValueList];
{$IFEND}
end;

procedure TDefaultLanguageProperty.GetValues(Proc: TGetStrProc);
var LNGI: Word;
    DT_Languages: TStringList;
    DT_Project: IOTAProject;
    DT_LangDir: String;
    SearchRec: TSearchRec;
    LangName: string;
    FindResult: Integer;
begin
  DT_Languages := TStringList.Create;
  DT_Languages.Add(DT_EngineOptions.DesignLang);
  DT_Project := GetActiveProject;
  if DT_Project.FileName <> '' then begin
    DT_LangDir := GetLangDir(GetApplicationDeploymentPath(DT_Project), DT_EngineOptions.Subdir);
    FindResult := FindFirst(DT_LangDir + '*.*',faAnyFile,SearchRec);
    try
      while FindResult = 0 do begin
        if ExtractFileExt(LowerCase(SearchRec.Name)) = LowerCase(DT_EngineOptions.LangFileExt) then begin
          LangName := GetLangIDs(DT_LangDir + SearchRec.Name, '[' + DT_EngineOptions.LangFileSign + ']', false).Name;
          if LangName <> '' then DT_Languages.Add(LangName);
        end;
        FindResult := FindNext(SearchRec);
      end;
    finally
      FindClose(SearchRec);
    end;
  end;
  for LNGI := 0 to DT_Languages.Count - 1 do Proc(DT_Languages.Strings[LNGI]);
  DT_Languages.Free;
end;

function TLangISOCodeEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paValueEditable];
end;

procedure TLangISOCodeEditor.GetValues(Proc: TGetStrProc);
var II: Integer;
begin
  for II := 0 to ISO_CODES_COUNT - 1 do Proc(ISO_639_1[II]);
end;

function LangManTagEditor.EditorDisabled(Component: TPersistent): Boolean;
begin
  Result := (Component is TLangManCore) OR (Component is TLangManComponent);
end;

function LangManTagEditor.GetAttributes: TPropertyAttributes;
begin
  if EditorDisabled(GetComponent(0)) then Result := [paValueEditable]
                                     else Result := [paValueList, paValueEditable];
end;

procedure LangManTagEditor.GetValues(Proc: TGetStrProc);
var Component: TPersistent;
begin
  Component := GetComponent(0);
  if EditorDisabled(Component) then Exit;
  Proc(BLOCK_TRANSLATE_TAG);
  if IsPublishedProp(Component, 'Text') then begin
    Proc(BLOCK_TEXT_TAG);
    Proc(BLOCK_TXT_OTHERS_TAG);
  end;
  if HaveHint(Component) then begin
    Proc(BLOCK_OTHERS_TAG);
    Proc(BLOCK_HINT_TAG);
  end;
{$IFDEF NEXTGEN}
  if GetValue[0] >= 'A' then Proc(UNBLOCK_TAG);
{$ELSE}
  if GetValue[1] >= 'A' then Proc(UNBLOCK_TAG);
{$ENDIF}
end;

function LangManTagEditor.GetValue: string;
var Tag: Integer;
begin
  Tag := GetOrdValue;
  case Tag of
    BLOCK_TEXT      : Result := BLOCK_TEXT_TAG;
    BLOCK_TXT_OTHERS: Result := BLOCK_TXT_OTHERS_TAG;
    BLOCK_HINT      : Result := BLOCK_HINT_TAG;
    BLOCK_OTHERS    : Result := BLOCK_OTHERS_TAG;
    BLOCK_TRANSLATE : Result := BLOCK_TRANSLATE_TAG;
    else Result := IntToStr(Tag);
  end;
end;

procedure LangManTagEditor.SetValue(const Value: string);
begin
  if Value = BLOCK_TRANSLATE_TAG then SetOrdValue(BLOCK_TRANSLATE)
                                 else begin
    if Value = BLOCK_OTHERS_TAG then SetOrdValue(BLOCK_OTHERS)
                                else begin
      if Value = BLOCK_HINT_TAG then SetOrdValue(BLOCK_HINT)
                                else begin
        if Value = BLOCK_TEXT_TAG then SetOrdValue(BLOCK_TEXT)
                                  else begin
          if Value = BLOCK_TXT_OTHERS_TAG then SetOrdValue(BLOCK_TXT_OTHERS)
                                          else begin
            if Value = UNBLOCK_TAG then inherited SetValue('0')
                                   else inherited SetValue(Value);
          end;
        end;
      end;
    end;
  end;
end;

procedure LexiconEditor.Edit;
var Editor: TStringsEditor;
begin
  try
    Editor := TStringsEditor.Create(Application);
    try
      Editor.ManageLexicon;
      Editor.Lines := (Component as TCustomDesignedLexicon).Items;
      if Editor.ShowModal = mrOK then begin
        (Component as TCustomDesignedLexicon).Items.Assign(Editor.Lines);
        Designer.Modified;
      end;
    finally
      Editor.Free;
    end;
  except
    on Exception do ;
  end;
end;

procedure RenameComponent(LangDir, LFExt, LFSign, OwnerName, OldName, NewName: string; var RenameFlags: Integer);
var RenameOwner, SaveChanges: Boolean;
    FindResult, LI: Integer;
    SearchRec: TSearchRec;
    Line, LangName, LexName: String;
    LangFile: TStringList;
    EndChar: PChar;
  {$IF CompilerVersion > 19}
    LangFileEnc: TEncoding;
  {$IFEND}
begin
  RenameOwner := OwnerName = OldName;
  LangFile := TStringList.Create;
  FindResult := FindFirst(LangDir + '*.*',faAnyFile,SearchRec);
  try
    while FindResult = 0 do begin
      LangFile.Clear;
      LangFile.NameValueSeparator := cTAB;
      if ExtractFileExt(LowerCase(SearchRec.Name)) = LowerCase(LFExt) then begin
        if FileExists(LangDir + SearchRec.Name) then begin
          SaveChanges := false;
        {$IF CompilerVersion > 19}
          LangFileEnc := GetLangFileEncoding(LangDir + SearchRec.Name);
          if Assigned(LangFileEnc) then begin
        {$IFEND}
           try
            LangFile.LoadFromFile(LangDir + SearchRec.Name);
            if Trim(LangFile.Strings[0]) <> LFSign then Abort;
            LI := 1;
            while NOT EoFile(LangFile, LI) DO begin
              if Pos(LANGUAGE_DESCRIPTOR, LangFile.Strings[LI]) > 0 then begin
                LangName := ExtrahovatZUvozovek(LangFile.Strings[LI]);
                if LangName <> '' then Break;
              end;
              Inc(LI);
            end;
            while NOT EoFile(LangFile, LI) DO begin
              Line := LangFile.ValueFromIndex[LI];
              if (Line[1] <> UVOZOVKA) AND (Pos(LEXICON_SEPARATOR, Line) > 0) then begin
                Inc(LI);
                Break;
              end;
              if (RenameFlags AND 128) <> 0 then begin
                Inc(LI);
                Continue;
              end;

              if RenameOwner and (OldName = GetDescriptor(Line, OWNER_DESCRIPTOR)) then begin
                LangFile.ValueFromIndex[LI] := ChangeDescValue(Line, OWNER_DESCRIPTOR, NewName, STREDNIK);
                SaveChanges := true;
              end else begin
                if OldName = GetDescriptorEx(Line, COMPONENT_DESCRIPTOR, EndChar) then begin
                  if RenameOwner and ('' = GetDescriptor(Line, OWNER_DESCRIPTOR)) then begin
                    LangFile.ValueFromIndex[LI] := ChangeDescValue(Line, COMPONENT_DESCRIPTOR, NewName, EndChar);
                    SaveChanges := true;
                  end else if (OwnerName = GetDescriptor(Line, OWNER_DESCRIPTOR)) then begin
                    LangFile.ValueFromIndex[LI] := ChangeDescValue(Line, COMPONENT_DESCRIPTOR, NewName, EndChar);
                    SaveChanges := true;
                  end;
                end;
              end;
              Inc(LI);
            end;

            if (RenameFlags AND 128) <> 0 then begin
              if (RenameFlags AND 64) <> 0 then begin
                // TLangManEngine.TLangFormLexicon
                while NOT EoFile(LangFile, LI) do begin
                  Line := LangFile.Strings[LI];
                  if (OldName = GetDescriptor(Line, LEXICON_DESCRIPTOR)) then begin
                    LangFile.Strings[LI] := ChangeDescValue(Line, LEXICON_DESCRIPTOR, NewName, STREDNIK);
                    SaveChanges := true;
                    Break;
                  end;
                  Inc(LI);
                end;
              end else begin
                // other TLexikon
                LexName := OwnerName + TECKA + OldName;
                while NOT EoFile(LangFile, LI) do begin
                  Line := LangFile.Strings[LI];
                  if RenameOwner then begin
                    if (OldName = ReadLexiconOwner(Line, LEXICON_DESCRIPTOR)) then begin
                      LangFile.Strings[LI] := ChangeDescValue(Line, LEXICON_DESCRIPTOR, NewName, TECKA);
                      SaveChanges := true;
                    end;
                  end else begin
                    if (LexName = GetDescriptor(Line, LEXICON_DESCRIPTOR)) then begin
                      LangFile.Strings[LI] := ChangeDescValue(Line, LEXICON_DESCRIPTOR, OwnerName + TECKA + NewName, STREDNIK);
                      SaveChanges := true;
                      Break;
                    end;
                  end;
                  Inc(LI);
                end;
              end;
            end;

           except
             on Exception do SaveChanges := false;
           end;
           try
            if SaveChanges then begin
              if ((RenameFlags AND 1) = 0) and
                 (MessageDlg('LangMan asks:' + #13#10 + 'Would you update language file(s)?',mtConfirmation,[mbYES,mbNO],0) = mrNO) then begin
                RenameFlags := -1;
                Break;
              end;
              RenameFlags := RenameFlags OR 1;
            {$IF CompilerVersion > 19}
              LangFile.SaveToFile(LangDir + SearchRec.Name, LangFileEnc);
            {$ELSE}
              LangFile.SaveToFile(LangDir + SearchRec.Name);
            {$IFEND}
            end;
           except
             on Exception do ; // ignore
           end;
        {$IF CompilerVersion > 19}
          end;
        {$IFEND}
        end;
      end;
      FindResult := FindNext(SearchRec);
    end;
  finally
    FindClose(SearchRec);
    LangFile.Free;
  end;
end;

procedure TNameProperty.SetValue(const Value: string);
var Component, ClientOwner: TComponent;
    LMEngine: TLangManCore;
    OldName, OwnerName: String;
    CI, RenameFlags: Integer;

  procedure UpdateLangFiles;
  var DT_Project: IOTAProject;
  begin
    DT_Project := GetActiveProject;
    if DT_Project.FileName <> '' then
      RenameComponent(GetLangDir(GetApplicationDeploymentPath(DT_Project),
                                 LMEngine.LangSubdirectory),
                      LMEngine.LangFileExtension,
                      '[' + LMEngine.LangFileSignature + ']',
                      OwnerName,
                      OldName,
                      Value,
                      RenameFlags);
  end;

begin
  OldName := GetValue;                                 // Store old component name
  Component := Designer.GetComponent(OldName);         // This Component renaming
  if (Component = nil) OR (OldName = '') then begin
    inherited SetValue(Value);
    Exit;
  end;
  ClientOwner := Component;                            // Owner Form or Top owner
  if (NOT (ClientOwner is TCustomForm)) and
     (NOT (ClientOwner is TCustomFrame)) and
     (NOT (ClientOwner is TDataModule)) and
     (ClientOwner.Owner <> nil) and
     (ClientOwner.Owner <> Application) then ClientOwner := ClientOwner.Owner;

  OwnerName := ClientOwner.Name;                       // Store old owner name
  if (ClientOwner <> Component) and (ClientOwner.Name = Value) then begin
    MessageDlg('Component name must be other than owner name!',mtError,[mbOK],0);
    Exit;
  end;
  inherited SetValue(Value);                           // Set New component Name
  if (Component is TLangManEngine) then begin
    RenameFlags := 128 + 64;
    LMEngine := TLangManEngine(Component);
    UpdateLangFiles;
  end else if (Component is TLMList) then begin
    RenameFlags := 128;
    LMEngine := (Component as TLMList).LangManEngine;
    if Assigned(LMEngine) then UpdateLangFiles;
  end else begin
    Inc(EngineAdjustID);
    RenameFlags := 0;
    if ClientOwner.ComponentCount > 0 then begin       // Find LangManClients and rename component in laguage files
      for CI := 0 to ClientOwner.ComponentCount - 1 do begin
        if ClientOwner.Components[CI] is TLangManComponent then begin
          LMEngine := (ClientOwner.Components[CI] as TLangManComponent).LangManEngine;
          if Assigned(LMEngine) then begin
            if EngineAdjustment(LMEngine, EngineAdjustID) then begin
              UpdateLangFiles;
              if RenameFlags < 0 then Break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

//+****************************************************************************
//+*  LangMan Components Register                                            **
//+****************************************************************************

procedure Register;
begin
  RegisterComponents(LANGMAN_IDE_VCL_GROUP_NAME,
                     [TLangManEngine, TLangManClient,
     {$IFDEF LMSMART}
                      TResourcesTranslator,
     {$ENDIF}
                      TDesignedLexicon, TProgrammableLexicon,
     {$IFDEF LMULT}
                      TInlineLexicon,
     {$ENDIF}
                      TLangCombo, TLangFlagsCombo, TLangFlag,
                      TValuedLabel, TLangManRichEdit]);

{$IFDEF DXE2}
  GroupDescendentsWith(TLangManEngine, Vcl.Controls.TControl);
  GroupDescendentsWith(TLangManClient, Vcl.Controls.TControl);
  GroupDescendentsWith(TDesignedLexicon, Vcl.Controls.TControl);
  GroupDescendentsWith(TProgrammableLexicon, Vcl.Controls.TControl);
{$IFDEF LMULT}
  GroupDescendentsWith(TInlineLexicon, Vcl.Controls.TControl);
{$ENDIF}
{$IFDEF LMSMART}
  GroupDescendentsWith(TResourcesTranslator, Vcl.Controls.TControl);
{$ENDIF}
{$ENDIF}

{$IFDEF LMDESI}
  RegisterComponentEditor(TLangManCore, TLanguageDesigner);
  RegisterComponentEditor(TLangManComponent, TComponentLanguageDesigner);
{$ELSE}
  RegisterComponentEditor(TCustomDesignedLexicon, LexiconEditor);
{$ENDIF}

{$IFDEF LMSMART}
  RegisterPropertyEditor(TypeInfo(String),TCustomResourcesTranslator,'OriginalLanguage',TLangISOCodeEditor);
{$ENDIF}

  RegisterPropertyEditor(TypeInfo(String),TLangManCore,'DefaultLanguage',TDefaultLanguageProperty);
  RegisterPropertyEditor(TypeInfo(String),TLangManCore,'DesignLangISOCode',TLangISOCodeEditor);
  RegisterPropertyEditor(TypeInfo(TStrings),TLexicon,'',TLexiconStringsProperty);
  RegisterPropertyEditor(TypeInfo(TComponentName),TComponent,'Name',TNameProperty);

{$IFDEF ENABLE_TSTRINGS_EDITOR}
  RegisterPropertyEditor(TypeInfo(TStrings),nil,'',TStringsProperty);
{$ENDIF}
{$IFDEF ENABLE_TAG_EDITOR}
{$IFDEF DXE2}
  RegisterPropertyEditor(TypeInfo(NativeInt),TComponent,'Tag',LangManTagEditor);
{$ELSE}
{$IFDEF VER210}
  RegisterPropertyEditor(TypeInfo(Integer),TComponent,'Tag',LangManTagEditor);
{$ELSE}
  RegisterPropertyEditor(TypeInfo(Longint),TComponent,'Tag',LangManTagEditor);
{$ENDIF}
{$ENDIF}
{$ENDIF}
end;

begin
  DesignTime := Application.MainForm <> nil;
{$ENDIF}

end.
