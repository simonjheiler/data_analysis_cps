capture log close
log using cpsjan2018.log, replace

/*------------------------------------------------
  by Jean Roth Thu Oct 25 14:39:42 EDT 2018
  Please report errors to jroth@nber.org
  NOTE:  This program is distributed under the GNU GPL.
  See end of this file and http://www.gnu.org/licenses/ for details.
  Run with do cpsjan2018
----------------------------------------------- */

/* The following line should contain
   the complete path and name of the raw data file.
   On a PC, use backslashes in paths as in C:\  */

local dat_name "/homes/data/cps/cpsjan2018.dat"
local dat_name "/homes/data/cps-basic/jan18pub.dat"

/* The following line should contain the path to your output '.dta' file */

local dta_name "cpsjan2018.dta"
*local dta_name "/homes/data/cps/cps`mon'`year'.dta"

/* The following line should contain the path to the data dictionary file */

local dct_name "cpsjan2018.dct"

/* The line below does NOT need to be changed */

quietly infile using "`dct_name'", using("`dat_name'") clear

/*------------------------------------------------

  All items, except those with one character, also can have values
  of -1, -2, or -3 even if the values are not in the documentation
  The meaning is
       -1 .Blank or not in universe
       -2 .Don't know
       -3 .Refused

  The following changes in variable names have been made, if necessary:
      '$' to 'd';            '-' to '_';              '%' to 'p';
      ($ = unedited data;     - = edited data;         % = allocated data)

  Decimal places have been made explict in the dictionary file.
  Stata resolves a missing value of -1 / # of decimal places as a missing value.
 -----------------------------------------------*/

** These note statements incorporate variable universes into the Stata data file.
note: by Jean Roth, jroth@nber.org Thu Oct 25 14:39:42 EDT 2018
note hrmonth: U ALL HHLD's IN SAMPLE
note hryear4: U ALL HHLDs IN SAMPLE
note hurespli: U ALL HHLDs IN SAMPLE
note hufinal: U ALL HHLDs IN SAMPLE
note hetenure: U ALL HHLDs IN SAMPLE
note hehousut: U HRINTSTA = 1 OR HUTYPB = 1-3
note hetelhhd: U ALL HHLDs IN SAMPLE
note hetelavl: U HRINTSTA = 1
note hephoneo: U HETELHHD = 2
note hefaminc: U HETELHHD = 1 OR HETELAVL = 1
note hutypea: U HETELHHD = 1 OR HETELAVL = 1
note hutypb: U HETELHHD = 1 OR HETELAVL = 1
note hutypc: U HETELHHD = 1 OR HETELAVL = 1
note hwhhwgt: U HETELHHD = 1 OR HETELAVL = 1
note hrintsta: U HRINTSTA = 1
note hrnumhou: U ALL HHLDs IN SAMPLE
note hrhtype: U ALL HHLDs IN SAMPLE
note hrmis: U ALL HHLDs IN SAMPLE
note huinttyp: U ALL HHLDs IN SAMPLE
note huprscnt: U ALL HHLDs IN SAMPLE
note hrlonglk: U ALL HHLDs IN SAMPLE
note hrhhid2: U ALL HHLDs IN SAMPLE
note hwhhwtln: U ALL HHLD's IN SAMPLE
note hubus: U HRINTSTA = 1
note hubusl1: U HRINTSTA = 1
note hubusl2: U HRINTSTA = 1
note hubusl3: U HRINTSTA = 1
note hubusl4: U HRINTSTA = 1
note gereg: U HRINTSTA = 1
note gediv: U ALL HHLD's IN SAMPLE
note gestfips: U ALL HHLD's IN SAMPLE
note gtcbsa: U ALL HHLD's IN SAMPLE
note gtco: U ALL HHLD's IN SAMPLE
note gtcbsast: U ALL HHLD's IN SAMPLE
note gtmetsta: U ALL HHLD's IN SAMPLE
note gtindvpc: U ALL HHLD's IN SAMPLE
note gtcbsasz: U ALL HHLD's IN SAMPLE
note gtcsa: U ALL HHLD's IN SAMPLE
note perrp: U ALL HHLD's IN SAMPLE
note peparent: U PRPERTYP = 1, 2, OR 3
note prtage: U EVERY PERSON
note prtfage: U PRPERTYP = 1, 2, 0R 3
note pemaritl: U PRPERTYP = 1, 2, 0R 3
note pespouse: U PRTAGE >= 15
note pesex: U PEMARITL = 1
note peafever: U PRPERTYP = 1, 2, 0R 3
note peafnow: U PRTAGE >=17
note peeduca: U PRPERTYP = 2 or 3
note ptdtrace: U PRPERTYP = 2 0R 3
note prdthsp: U PRPERTYP = 1, 2, 0R 3
note puchinhh: U PEHSPNON = 1
note pulineno: U PEHSPNON = 1
note prfamnum: U PEHSPNON = 1
note prfamrel: U PRPERTYP = 1, 2, 0R 3
note prfamtyp: U PRPERTYP = 1, 2, 0R 3
note pehspnon: U PRPERTYP = 1, 2, 0R 3
note prmarsta: U PRPERTYP = 1, 2, 0R 3
note prpertyp: U PRPERTYP = 2 0R 3
note penatvty: U ALL HOUSEHOLD MEMBERS
note pemntvty: U PRPERTYP = 1, 2, 0R 3
note pefntvty: U PRPERTYP = 1, 2, 0R 3
note prcitshp: U PRPERTYP = 1, 2, 0R 3
note prcitflg: U PRPERTYP = 1, 2, 0R 3
note prinusyr: U PRPERTYP = 1, 2, 0R 3
note puslfprx: U PRCITSHP = 2, 3, 4, OR 5
note pemlr: U PRCITSHP = 2, 3, 4, OR 5
note puwk: U PRPERTYP = 2
note pubus1: U PRPERTYP = 2
note pubus2ot: U PRPERTYP = 2
note pubusck1: U PRPERTYP = 2
note pubusck2: U PRPERTYP = 2
note pubusck3: U PRPERTYP = 2
note pubusck4: U PRPERTYP = 2
note puretot: U PRPERTYP = 2
note pudis: U PRPERTYP = 2
note peret1: U PRPERTYP = 2
note pudis1: U PEMLR = 5 AND (PURETOT = 1 OR
note pudis2: U PEMLR = 5 AND (PURETOT = 1 OR
note puabsot: U PEMLR = 5 AND (PURETOT = 1 OR
note pulay: U PEMLR = 5 AND (PURETOT = 1 OR
note peabsrsn: U PEMLR = 5 AND (PURETOT = 1 OR
note peabspdo: U PEMLR = 2
note pemjot: U PEABSRSN = 4-12, 14
note pemjnum: U PEMLR = 1, 2
note pehrusl1: U PEMJOT = 1
note pehrusl2: U PEMJOT = 1 OR 2 AND PEMLR = 1 OR 2
note pehrftpt: U PEMJOT = 1 AND PEMLR = 1 OR 2
note pehruslt: U PEHRUSL1 = -4 OR PEHRUSL2 = -4
note pehrwant: U PEMLR = 1 OR 2
note pehrrsn1: U PEMLR = 1 AND (PEHRUSLT = 0-34
note pehrrsn2: U PEHRWANT = 1 (PEMLR = 1 AND PEHRUSLT < 35)
note pehrrsn3: U PEHRWANT = 2 (PEMLR = 1 AND PEHRUSLT < 35)
note puhroff1: U PEHRACTT = 1-34 AND PUHRCK7 NE 1, 2
note puhroff2: U PEHRACTT = 1-34 AND PUHRCK7 NE 1, 2
note puhrot1: U PEHRACTT = 1-34 AND PUHRCK7 NE 1, 2
note puhrot2: U PEHRACTT = 1-34 AND PUHRCK7 NE 1, 2
note pehract1: U PEHRACTT = 1-34 AND PUHRCK7 NE 1, 2
note pehract2: U PEMLR = 1
note pehractt: U PEMLR = 1 AND PEMJOT = 1
note pehravl: U PEMLR = 1
note puhrck1: U PEHRACTT = 1-34 (PEMLR = 1 AND
note puhrck2: U PEHRACTT = 1-34 (PEMLR = 1 AND
note puhrck3: U PEHRACTT = 1-34 (PEMLR = 1 AND
note puhrck4: U PEHRACTT = 1-34 (PEMLR = 1 AND
note puhrck5: U PEHRACTT = 1-34 (PEMLR = 1 AND
note puhrck6: U PEHRACTT = 1-34 (PEMLR = 1 AND
note puhrck7: U PEHRACTT = 1-34 (PEMLR = 1 AND
note puhrck12: U PEHRACTT = 1-34 (PEMLR = 1 AND
note pulaydt: U PEHRACTT = 1-34 (PEMLR = 1 AND
note pulay6m: U PEHRACTT = 1-34 (PEMLR = 1 AND
note pelayavl: U PEHRACTT = 1-34 (PEMLR = 1 AND
note pulayavr: U PEMLR = 3
note pelaylk: U PEMLR = 3
note pelaydur: U PELAYAVL= 1, 2
note pelayfto: U PELAYAVL= 1, 2
note pulayck1: U PELAYDUR = 0-120
note pulayck2: U PELAYDUR = 0-120
note pulayck3: U PELAYDUR = 0-120
note pulk: U PELAYDUR = 0-120
note pelkm1: U PELAYDUR = 0-120
note pulkm2: U PEMLR = 4
note pulkm3: U PEMLR = 4
note pulkm4: U PEMLR = 4
note pulkm5: U PEMLR = 4
note pulkm6: U PEMLR = 4
note pulkdk1: U PEMLR = 4
note pulkdk2: U PEMLR = 4
note pulkdk3: U PEMLR = 4
note pulkdk4: U PEMLR = 4
note pulkdk5: U PEMLR = 4
note pulkdk6: U PEMLR = 4
note pulkps1: U PEMLR = 4
note pulkps2: U PEMLR = 4
note pulkps3: U PEMLR = 4
note pulkps4: U PEMLR = 4
note pulkps5: U PEMLR = 4
note pulkps6: U PEMLR = 4
note pelkavl: U PEMLR = 4
note pulkavr: U PELKM1 = 1 - 13
note pelkll1o: U PELKM1 = 1 - 13
note pelkll2o: U PELKAVL = 1-2
note pelklwo: U PELKLL1O = 1 OR 3
note pelkdur: U PELKLL1O = 1 - 4
note pelkfto: U PELKLWO = 1 - 3
note pedwwnto: U PELKDUR = 0-120
note pedwrsn: U PUDWCK1 = 3, 4, -1
note pedwlko: U PUDWCK4 = 4, -1
note pedwwk: U (PUDWCK4 = 1-3) or (PEDWRSN = 1-11)
note pedw4wk: U PEDWLKO = 1
note pedwlkwk: U PEDWWK = 1
note pedwavl: U PEDW4WK = 2
note pedwavr: U (PEDWWK = 2) or (PEDWLKWK = 1)
note pudwck1: U PEDWAVL = 2
note pudwck2: U PEDWAVL = 2
note pudwck3: U PEDWAVL = 2
note pudwck4: U PEDWAVL = 2
note pudwck5: U PEDWAVL = 2
note pejhwko: U PEDWAVL = 2
note pujhdp1o: U HRMIS = 4 or 8 AND PEMLR = 5, 6, AND 7
note pejhrsn: U HRMIS = 4 or 8 AND PEMLR = 5, 6, AND 7
note pejhwant: U PEJHWKO = 1
note pujhck1: U (PEJHWKO = 2) or (PEJHRSN = 1-8)
note pujhck2: U (PEJHWKO = 2) or (PEJHRSN = 1-8)
note prabsrea: U (PEJHWKO = 2) or (PEJHRSN = 1-8)
note prcivlf: U PEMLR = 2
note prdisc: U PEMLR = 1-7
note premphrs: U PRJOBSEA = 1-4
note prempnot: U PEMLR = 1-7
note prexplf: U PEMLR = 1-7
note prftlf: U PEMLR = 1-4 AND
note prhrusl: U PEMLR = 1-4
note prjobsea: U PEMLR = 1-2
note prpthrs: U PRWNTJOB = 1
note prptrea: U PEMLR = 1 AND
note prunedur: U PEMLR = 1 AND
note pruntype: U PEMLR = 3-4
note prwksch: U PEMLR = 3-4
note prwkstat: U PEMLR = 1 - 7
note prwntjob: U PEMLR = 1-7
note pujhck3: U PEMLR = 5-7
note pujhck4: U PEMLR = 5-7
note pujhck5: U PEMLR = 5-7
note puiodp1: U PEMLR = 5-7
note puiodp2: U PEMLR = 5-7
note puiodp3: U PEMLR = 5-7
note peio1cow: U PEMLR = 5-7
note puio1mfg: U (PEMLR = 1-3) OR
note peio2cow: U (PEMLR = 1-3) OR
note puio2mfg: U PRIOELG = 1 and PEMJOT = 1 AND HRMIS = 4,8
note puiock1: U PRIOELG = 1 and PEMJOT = 1 AND HRMIS = 4,8
note puiock2: U PRIOELG = 1 and PEMJOT = 1 AND HRMIS = 4,8
note puiock3: U PRIOELG = 1 and PEMJOT = 1 AND HRMIS = 4,8
note prioelg: U PRIOELG = 1 and PEMJOT = 1 AND HRMIS = 4,8
note pragna: U PEMLR = 1-3,
note prcow1: U PRIOELG = 1
note prcow2: U PRIOELG = 1
note prcowpg: U PRIOELG = 1 AND PEMJOT = 1 AND
note prdtcow1: U PEIO1COW = 1 - 5
note prdtcow2: U PRIOELG = 1
note prdtind1: U PRIOELG = 1 AND PEMJOT = 1 AND
note prdtind2: U PRIOELG = 1
note prdtocc1: U PRIOELG = 1 AND PEMJOT = 1 AND HRMIS = 4 OR 8
note prdtocc2: U PRIOELG = 1
note premp: U PRIOELG = 1 AND PEMJOT = 1 AND HRMIS = 4 OR 8
note prmjind1: U PEMLR = 1 OR 2
note prmjind2: U PRDTIND1 = 1-51
note prmjocc1: U PRDTIND2 = 1-51
note prmjocc2: U PRDTOCC1 = 1-46
note prmjocgr: U PRDTOCC2 = 1-46
note prnagpws: U PRMJOCC = 1-11
note prnagws: U PRCOW1 = 1 AND
note prsjmj: U PEMLR = 1-4
note prerelg: U PEMLR = 1 OR 2
note peernuot: U PEMLR = 1-2 AND HRMIS = 4 OR 8
note peernper: U PRERELG = 1
note peernrt: U PRERELG = 1
note peernhry: U PEERNPER = 2-7
note puernh1c: U PRERELG = 1
note peernh2: U PRERELG = 1
note peernh1o: U PEERNRT = 1
note prernhly: U PEERNPER = 1
note pthr: U PEERNPER = 1 OR PEERNRT = 1
note peernhro: U PEERNPER = 1 OR PEERNRT = 1
note prernwa: U PEERNH1O = ENTRY
note ptwk: U PRERELG = 1
note peern: U PRERELG = 1
note puern2: U PEERNUOT = 1 AND PEERNPER = 1
note ptot: U PEERNUOT = 1 AND PEERNPER = 1
note peernwkp: U PEERNUOT = 1 AND PEERNPER = 1
note peernlab: U PEERNPER = 6
note peerncov: U (PEIO1COW = 1-5 AND PEMLR = 1-2
note penlfjh: U (PEIO1COW = 1-5 AND PEMLR = 1-2
note penlfret: U HRMIS = 4 OR 8 AND PEMLR = 3-7
note penlfact: U PRTAGE = 50+ AND PEMLR = 3-7
note punlfck1: U (PRTAGE = 14-49) or (PENLFRET = 2)
note punlfck2: U (PRTAGE = 14-49) or (PENLFRET = 2)
note peschenr: U (PRTAGE = 14-49) or (PENLFRET = 2)
note peschft: U PRPERTYP = 2 and PRTAGE = 16-54
note peschlvl: U PESCHLVL = 1, 2
note prnlfsch: U PESCHENR = 1
note pwfmwgt: U PENLFACT = -1 OR 1-6 AND PRTAGE = 16-24
note pwlgwgt: U PRPERTYP = 1-3
note pworwgt: U PRPERTYP = 2
note pwsswgt: U PRPERTYP = 2
note pwvetwgt: U PRPERTYP = 1-3
note prchld: U PRPERTYP = 2
note prnmchld: U PRFAMREL = 1 or 2
note pxpdemp1: U PRFAMREL = 1 or 2
note prwernal: U PRFAMREL = 1 or 2
note prhernal: U PRERELG = 1
note hxtenure: U PRERNHRY = 1
note hxhousut: U PRERNHRY = 1
note hxtelhhd: U PRERNHRY = 1
note hxtelavl: U PRERNHRY = 1
note hxphoneo: U PRERNHRY = 1
note pxinusyr: U PRERNHRY = 1
note pxrrp: U PRERNHRY = 1
note pxparent: U PRERNHRY = 1
note pxage: U PRERNHRY = 1
note pxmaritl: U PRERNHRY = 1
note pxspouse: U PRERNHRY = 1
note pxsex: U PRERNHRY = 1
note pxafwhn1: U PRERNHRY = 1
note pxafnow: U PRERNHRY = 1
note pxeduca: U PRERNHRY = 1
note pxrace1: U PRERNHRY = 1
note pxnatvty: U PRERNHRY = 1
note pxmntvty: U PRERNHRY = 1
note pxfntvty: U PRERNHRY = 1
note pxnmemp1: U PRERNHRY = 1
note pxhspnon: U PRERNHRY = 1
note pxmlr: U PRERNHRY = 1
note pxret1: U PRERNHRY = 1
note pxabsrsn: U PRERNHRY = 1
note pxabspdo: U PRERNHRY = 1
note pxmjot: U PRERNHRY = 1
note pxmjnum: U PRERNHRY = 1
note pxhrusl1: U PRERNHRY = 1
note pxhrusl2: U PRERNHRY = 1
note pxhrftpt: U PRERNHRY = 1
note pxhruslt: U PRERNHRY = 1
note pxhrwant: U PRERNHRY = 1
note pxhrrsn1: U PRERNHRY = 1
note pxhrrsn2: U PRERNHRY = 1
note pxhract1: U PRERNHRY = 1
note pxhract2: U PRERNHRY = 1
note pxhractt: U PRERNHRY = 1
note pxhrrsn3: U PRERNHRY = 1
note pxhravl: U PRERNHRY = 1
note pxlayavl: U PRERNHRY = 1
note pxlaylk: U PRERNHRY = 1
note pxlaydur: U PRERNHRY = 1
note pxlayfto: U PRERNHRY = 1
note pxlkm1: U PRERNHRY = 1
note pxlkavl: U PRERNHRY = 1
note pxlkll1o: U PRERNHRY = 1
note pxlkll2o: U PRERNHRY = 1
note pxlklwo: U PRERNHRY = 1
note pxlkdur: U PRERNHRY = 1
note pxlkfto: U PRERNHRY = 1
note pxdwwnto: U PRERNHRY = 1
note pxdwrsn: U PRERNHRY = 1
note pxdwlko: U PRERNHRY = 1
note pxdwwk: U PRERNHRY = 1
note pxdw4wk: U PRERNHRY = 1
note pxdwlkwk: U PRERNHRY = 1
note pxdwavl: U PRERNHRY = 1
note pxdwavr: U PRERNHRY = 1
note pxjhwko: U PRERNHRY = 1
note pxjhrsn: U PRERNHRY = 1
note pxjhwant: U PRERNHRY = 1
note pxio1cow: U PRERNHRY = 1
note pxio1icd: U PRERNHRY = 1
note pxio1ocd: U PRERNHRY = 1
note pxio2cow: U PRERNHRY = 1
note pxio2icd: U PRERNHRY = 1
note pxio2ocd: U PRERNHRY = 1
note pxernuot: U PRERNHRY = 1
note pxernper: U PRERNHRY = 1
note pxernh1o: U PRERNHRY = 1
note pxernhro: U PRERNHRY = 1
note pxern: U PRERNHRY = 1
note pxpdemp2: U PRERNHRY = 1
note pxnmemp2: U PRERNHRY = 1
note pxernwkp: U PRERNHRY = 1
note pxernrt: U PRERNHRY = 1
note pxernhry: U PRERNHRY = 1
note pxernh2: U PRERNHRY = 1
note pxernlab: U PRERNHRY = 1
note pxerncov: U PRERNHRY = 1
note pxnlfjh: U PRERNHRY = 1
note pxnlfret: U PRERNHRY = 1
note pxnlfact: U PRERNHRY = 1
note pxschenr: U PRERNHRY = 1
note pxschft: U PRERNHRY = 1
note pxschlvl: U PRERNHRY = 1
note qstnum: U PRERNHRY = 1
note occurnum: U PRERNHRY = 1
note pedipged: U PRERNHRY = 1
note pehgcomp: U PRERNHRY = 1
note pecyc: U PRERNHRY = 1
note pxdipged: U PEEDUCA =40-42
note pxhgcomp: U PEEDUCA =40-42
note pxcyc: U PEEDUCA =40-42
note pwcmpwgt: U PEEDUCA =40-42
note peio1icd: U PRPERTYP = 2 AND
note peio1ocd: U (PEMLR = 1-3)
note peio2icd: U (PEMLR = 1-3)
note peio2ocd: U PEMJOT = 1 AND HRMIS = 4 OR 8
note primind1: U PEMJOT = 1 AND HRMIS = 4 OR 8
note primind2: U PRIOELG = 1
note peafwhn1: U PRIOELG = 1 AND PEMJOT = 1 AND HRMIS = 4 OR 8
note peafwhn2: U PEAFEVER = 1
note peafwhn3: U PEAFEVER = 1
note peafwhn4: U PEAFEVER = 1
note pxafever: U PEAFEVER = 1
note pelndad: U PEAFEVER = 1
note pelnmom: U ALL
note pedadtyp: U ALL
note pemomtyp: U ALL
note pecohab: U ALL
note pxlndad: U ALL
note pxlnmom: U ALL
note pxdadtyp: U ALL
note pxmomtyp: U ALL
note pxcohab: U ALL
note pedisear: U ALL
note pediseye: U PRPERTYP = 2
note pedisrem: U PRPERTYP = 2
note pedisphy: U PRPERTYP = 2
note pedisdrs: U PRPERTYP = 2
note pedisout: U PRPERTYP = 2
note prdisflg: U PRPERTYP = 2
note pxdisear: U PEDISEAR OR
note pxdiseye: U PEDISEAR OR
note pxdisrem: U PEDISEAR OR
note pxdisphy: U PEDISEAR OR
note pxdisdrs: U PEDISEAR OR
note pxdisout: U PEDISEAR OR
note hxfaminc: U PEDISEAR OR
note prdasian: U PEDISEAR OR
note pepdemp1: U PTDTRACE = 4
note ptnmemp1: U HRMIS = 3 or 4 and
note pepdemp2: U PEPDEMP1 = 1
note ptnmemp2: U HRMIS = 3 or 4 and
note pecert1: U PEPDEMP1 = 1
note pecert2: U PRPERTYP = 2
note pecert3: U PECERT1 = 1
note pxcert1: U PECERT2 = 1
note pxcert2: U PECERT2 = 1
note pxcert3: U PECERT2 = 1
note pesd1: U PECERT2 = 1
*Everything below this point, aside from the final save, are value labels

#delimit ;

;
label values hufinal  hufinal;
label define hufinal
	1           "FULLY COMPLETE CATI INTERVIEW"
	2           "PARTIALLY COMPLETED CATI INTERVIEW"
	3           "COMPLETE BUT PERSONAL VISIT REQUESTED NEXT MONTH"
	4           "PARTIAL, NOT COMPLETE AT CLOSEOUT"
	5           "LABOR FORCE COMPLETE, SUPPLEMENT INCOMPLETE - CATI"
	6           "LF COMPLETE, SUPPLEMENT DK ITEMS INCOMPLETE AT CLOSEOUT--ASEC ONLY"
	20          "HH OCCUPIED ENTIRELY BY ARMED FORCES MEMBERS OR ALL UNDER 15 YEARS OF AGE"
	201         "CAPI COMPLETE"
	202         "CALLBACK NEEDED"
	203         "SUFFICIENT PARTIAL - PRECLOSEOUT"
	204         "SUFFICIENT PARTIAL - AT CLOSEOUT"
	205         "LABOR FORCE COMPLETE, - SUPPL. INCOMPLETE - CAPI"
	213         "LANGUAGE BARRIER"
	214         "UNABLE TO LOCATE"
	216         "NO ONE HOME"
	217         "TEMPORARILY ABSENT"
	218         "REFUSED"
	219         "OTHER OCCUPIED - SPECIFY"
	223         "ENTIRE HOUSEHOLD ARMED FORCES"
	224         "ENTIRE HOUSEHOLD UNDER 15"
	225         "TEMP. OCCUPIED W/PERSONS WITH URE"
	226         "VACANT REGULAR"
	227         "VACANT - STORAGE OF HHLD FURNITURE"
	228         "UNFIT, TO BE DEMOLISHED"
	229         "UNDER CONSTRUCTION, NOT READY"
	230         "CONVERTED TO TEMP BUSINESS OR STORAGE"
	231         "UNOCCUPIED TENT OR TRAILER SITE"
	232         "PERMIT GRANTED - CONSTRUCTION NOT STARTED"
	233         "OTHER - SPECIFY"
	240         "DEMOLISHED"
	241         "HOUSE OR TRAILER MOVED"
	242         "OUTSIDE SEGMENT"
	243         "CONVERTED TO PERM. BUSINESS OR STORAGE"
	244         "MERGED"
	245         "CONDEMNED"
	247         "UNUSED SERIAL NUMBER OR LISTING SHEET"
	248         "OTHER - SPECIFY"
	258         "UNLOCATABLE SAMPLE ADDRESS"
	259         "UNIT DOES NOT EXIST/OUT OF SCOPE"
	256         "REMOVED DURING SUB-SAMPLING"
	257         "UNIT ALREADY HAD A CHANCE OF SELECTION"
;
label values hetenure hetenure;
label define hetenure
	1           "OWNED OR BEING BOUGHT BY A HH MEMBER"
	2           "RENTED FOR CASH"
	3           "OCCUPIED WITHOUT PAYMENT OF CASH RENT"
;
label values hehousut hehousut;
label define hehousut
	0           "OTHER UNIT"
	1           "HOUSE, APARTMENT, FLAT"
	2           "HU IN NONTRANSIENT HOTEL, MOTEL, ETC."
	3           "HU PERMANENT IN TRANSIENT HOTEL, MOTEL"
	4           "HU IN ROOMING HOUSE"
	5           "MOBILE HOME OR TRAILER W/NO PERM. ROOM ADDED"
	6           "MOBILE HOME OR TRAILER W/1 OR MORE PERM. ROOMS ADDED"
	7           "HU NOT SPECIFIED ABOVE"
	8           "QUARTERS NOT HU IN ROOMING OR BRDING HS"
	9           "UNIT NOT PERM. IN TRANSIENT HOTL, MOTL"
	10          "UNOCCUPIED TENT SITE OR TRLR SITE"
	11          "STUDENT QUARTERS IN COLLEGE DORM"
	12          "OTHER UNIT NOT SPECIFIED ABOVE"
;
label values hetelhhd hetelhhd;
label define hetelhhd
	1           "YES"
	2           "NO"
;
label values hetelavl hetelavl;
label define hetelavl
	1           "YES"
	2           "NO"
;
label values hephoneo hephoneo;
label define hephoneo
	0           "NO"
	1           "YES"
;
label values hefaminc hefaminc;
label define hefaminc
	1           "LESS THAN $5,000"
	2           "5,000 TO 7,499"
	3           "7,500 TO 9,999"
	4           "10,000 TO 12,499"
	5           "12,500 TO 14,999"
	6           "15,000 TO 19,999"
	7           "20,000 TO 24,999"
	8           "25,000 TO 29,999"
	9           "30,000 TO 34,999"
	10          "35,000 TO 39,999"
	11          "40,000 TO 49,999"
	12          "50,000 TO 59,999"
	13          "60,000 TO 74,999"
	14          "75,000 TO 99,999"
	15          "100,000 TO 149,999"
	16          "150,000 OR MORE"
;
label values hutypea  hutypea;
label define hutypea
	1           "NO ONE HOME (NOH)"
	2           "TEMPORARILY ABSENT (TA)"
	3           "REFUSED (REF)"
	4           "LANGUAGE BARRIER"
	5           "UNABLE TO LOCATE"
	6           "OTHER OCCUPIED - SPECIFY"
;
label values hutypb   hutypb;
label define hutypb
	1           "VACANT REGULAR"
	2           "TEMPORARILY OCCUPIED BY PERSONS W/ URE"
	3           "VACANT-STORAGE OF HHLD FURNITURE"
	4           "UNFIT OR TO BE DEMOLISHED"
	5           "UNDER CONSTRUCTION, NOT READY"
	6           "CONVERTED TO TEMP BUSINESS OR STORAGE"
	7           "UNOCCUPIED TENT SITE OR TRAILER SITE"
	8           "PERMIT GRANTED CONSTRUCTION NOT STARTED"
	9           "OTHER TYPE B - SPECIFY"
;
label values hutypc   hutypc;
label define hutypc
	1           "DEMOLISHED"
	2           "HOUSE OR TRAILER MOVED"
	3           "OUTSIDE SEGMENT"
	4           "CONVERTED TO PERM. BUSINESS OR STORAGE"
	5           "MERGED"
	6           "CONDEMNED"
	7           "UNUSED LINE OF LISTING SHEET"
	8           "UNLOCATABLE SAMPLE ADDRESS"
	9           "UNIT DOES NOT EXIST/OUT OF SCOPE"
	10          "OTHER - SPECIFY"
;
label values hrintsta hrintsta;
label define hrintsta
	1           "INTERVIEW"
	2           "TYPE A NON-INTERVIEW"
	3           "TYPE B NON-INTERVIEW"
	4           "TYPE C NON-INTERVIEW"
;
label values hrhtype  hrhtype;
label define hrhtype
	0           "NON-INTERVIEW HOUSEHOLD"
	1           "HUSBAND/WIFE PRIMARY FAMILY (NEITHER AF)"
	2           "HUSB/WIFE PRIM. FAMILY (EITHER/BOTH AF)"
	3           "UNMARRIED CIVILIAN MALE-PRIM. FAM HHLDER"
	4           "UNMARRIED CIV. FEMALE-PRIM FAM HHLDER"
	5           "PRIMARY FAMILY HHLDER-RP IN AF, UNMAR."
	6           "CIVILIAN MALE PRIMARY INDIVIDUAL"
	7           "CIVILIAN FEMALE PRIMARY INDIVIDUAL"
	8           "PRIMARY INDIVIDUAL HHLD-RP IN AF"
	9           "GROUP QUARTERS WITH FAMILY"
	10          "GROUP QUARTERS WITHOUT FAMILY"
;
label values huinttyp huinttyp;
label define huinttyp
	0           "NONINTERVIEW/INDETERMINATE"
	1           "PERSONAL"
	2           "TELEPHONE"
;
label values hrlonglk hrlonglk;
label define hrlonglk
	0           "MIS 1 OR REPLACEMENT HH (NO LINK)"
	2           "MIS 2-4 OR MIS 6-8"
	3           "MIS 5"
;
label values hubus    hubus;
label define hubus
	1           "YES"
	2           "NO"
;
label values gereg    gereg;
label define gereg
	1           "NORTHEAST"
	2           "MIDWEST (FORMERLY NORTH CENTRAL)"
	3           "SOUTH"
	4           "WEST"
;
label values gediv    gediv;
label define gediv
	1           "NEW ENGLAND"
	2           "MIDDLE ATLANTIC"
	3           "EAST NORTH CENTRAL"
	4           "WEST NORTH CENTRAL"
	5           "SOUTH ATLANTIC"
	6           "EAST SOUTH CENTRAL"
	7           "WEST SOUTH CENTRAL"
	8           "MOUNTAIN"
	9           "PACIFIC"
;
label values gestfips gestfips;
label define gestfips
	1           "AL"
	2           "AK"
	4           "AZ"
	5           "AR"
	6           "CA"
	8           "CO"
	9           "CT"
	10          "DE"
	11          "DC"
	12          "FL"
	13          "GA"
	15          "HI"
	16          "ID"
	17          "IL"
	18          "IN"
	19          "IA"
	20          "KS"
	21          "KY"
	22          "LA"
	23          "ME"
	24          "MD"
	25          "MA"
	26          "MI"
	27          "MN"
	28          "MS"
	29          "MO"
	30          "MT"
	31          "NE"
	32          "NV"
	33          "NH"
	34          "NJ"
	35          "NM"
	36          "NY"
	37          "NC"
	38          "ND"
	39          "OH"
	40          "OK"
	41          "OR"
	42          "PA"
	44          "RI"
	45          "SC"
	46          "SD"
	47          "TN"
	48          "TX"
	49          "UT"
	50          "VT"
	51          "VA"
	53          "WA"
	54          "WV"
	55          "WI"
	56          "WY"
;
label values gtcbsa   gtcbsa;
label define gtcbsa
	0           "NOT IDENTIFIED OR NONMETROPOLITAN"
	10500       "Albany, GA (Baker, Terrell, and Worth Counties not in sample)"
	10580       "Albany-Schenectady-Troy, NY"
	10740       "Albuquerque, NM"
	10900       "Allentown-Bethlehem-Easton, PA-NJ"
	11020       "Altoona, PA"
	11100       "Amarillo, TX (Armstrong and Carson Counties not in sample)"
	11300       "Anderson, IN"
	11340       "Anderson, SC"
	11460       "Ann Arbor, MI"
	11500       "Anniston-Oxford, AL"
	11540       "Appleton, WI"
	11700       "Asheville, NC (Haywood and Madison Counties not in sample)"
	12020       "Athens-Clarke County, GA (Oglethorpe County not in sample)"
	12060       "Atlanta-Sandy Springs-Marietta, GA (Haralson, Heard, Jasper, Meriwether and Spalding Counties not in sample)"
	12100       "Atlantic City, NJ"
	12260       "Augusta-Richmond County, GA-SC"
	12420       "Austin-Round Rock, TX"
	12540       "Bakersfield, CA"
	12580       "Baltimore-Towson, MD"
	12940       "Baton Rouge, LA"
	13140       "Beaumont-Port Arthur, TX"
	13380       "Bellingham, WA"
	13460       "Bend, OR"
	13740       "Billings, MT (Carbon County not in sample)"
	13780       "Binghamton, NY"
	13820       "Birmingham-Hoover, AL"
	14020       "Bloomington, IN (Owen County not in sample)"
	14060       "Bloomington-Normal IL"
	14260       "Boise City-Nampa, ID (Owyhee County not in sample)"
	14500       "Boulder, CO"
	14540       "Bowling Green, KY"
	14740       "Bremerton-Silverdale, WA"
	15180       "Brownsville-Harlingen, TX"
	15380       "Buffalo-Niagara Falls, NY"
	15940       "Canton-Massillon, OH"
	15980       "Cape Coral-Fort Myers, FL"
	16300       "Cedar Rapids, IA (Benton and Jones Counties not in sample)"
	16580       "Champaign-Urbana, IL (Ford County not in sample)"
	16620       "Charleston, WV (Clay County not in sample)"
	16700       "Charleston-North Charleston, SC"
	16740       "Charlotte-Gastonia-Concord, NC-SC (Anson County, NC not in sample)"
	16860       "Chattanooga, TN-GA"
	16980       "Chicago-Naperville-Joliet, IL-IN-WI (DeKalb, IL; Jasper, IN; and Kenosha, WI Counties not in sample)"
	17020       "Chico, CA"
	17140       "Cincinnati-Middletown, OH-KY-IN (Franklin County , IN not in sample; Dearborn and Ohio Counties, IN not identified)"
	17460       "Cleveland-Elyria-Mentor, OH"
	17660       "Coeur d'Alene, ID"
	17820       "Colorado Springs, CO"
	17860       "Columbia, MO (Howard County not in sample)"
	17900       "Columbia, SC"
	17980       "Columbus, GA-AL (Harris County, GA and Russell County, Alabama not in sample)"
	18140       "Columbus, OH (Morrow County not in sample)"
	18580       "Corpus Christi, TX"
	19100       "Dallas-Fort Worth-Arlington, TX (Delta and Hunt Counties not in sample)"
	19340       "Davenport-Moline-Rock Island, IA-IL"
	19380       "Dayton, OH"
	19460       "Decatur, Al"
	19500       "Decatur, IL"
	19660       "Deltona-Daytona Beach-Ormond Beach, FL"
	19740       "Denver-Aurora, CO"
	19780       "Des Moines, IA"
	19820       "Detroit-Warren-Livonia, MI"
	20100       "Dover, DE"
	20260       "Duluth, MN-WI (Carlton County, MN not in sample, WI portion not identified)"
	20500       "Durham, NC"
	20740       "Eau Claire, WI"
	20940       "El Centro, CA"
	21340       "El Paso, TX"
	21500       "Erie, PA"
	21660       "Eugene-Springfield, OR"
	21780       "Evansville, IN-KY (Gibson County, IN and Kentucky portion not in sample)"
	22020       "Fargo, ND-MN (MN portion not identified)"
	22140       "Farmington, NM"
	22180       "Fayetteville, NC"
	22220       "Fayetteville-Springdale-Rogers, AR-MO (Madison County, AR and Missouri portion not in sample)"
	22420       "Flint, MI"
	22460       "Florence, AL"
	22660       "Fort Collins-Loveland, CO"
	22900       "Fort Smith, AR-OK (Oklahoma portion not in sample)"
	23020       "Fort Walton Beach-Crestview-Destin, FL"
	23060       "Fort Wayne, IN"
	23420       "Fresno, CA"
	23540       "Gainesville, FL (Gilchrist County not in sample)"
	24340       "Grand Rapids-Wyoming, MI"
	24540       "Greeley, CO"
	24580       "Green Bay, WI (Oconto County not in sample)"
	24660       "Greensboro-High Point, NC"
	24860       "Greenville, SC (Laurens and Pickens Counties not in sample)"
	25060       "Gulfport-Biloxi, MS (Stone County not in sample)"
	25180       "Hagerstown-Martinsburg, MD-WV (Berkeley County, WV not identified and Morgan County, WV not in sample)"
	25420       "Harrisburg-Carlisle, PA"
	25500       "Harrisonburg, VA"
	25860       "Hickory-Morganton-Lenoir, NC (Caldwell County not in sample)"
	26100       "Holland-Grand Haven, MI"
	26180       "Honolulu, HI"
	26420       "Houston-Baytown-Sugar Land, TX"
	26580       "Huntington-Ashland, WV-KY-OH (Kentucky and Ohio portions not identified)"
	26620       "Huntsville, AL"
	26900       "Indianapolis, IN"
	26980       "Iowa City, IA (Washington County not in sample)"
	27100       "Jackson, MI"
	27140       "Jackson, MS"
	27260       "Jacksonville, FL"
	27340       "Jacksonville, NC"
	27500       "Janesville, WI"
	27740       "Johnson City, TN"
	27780       "Johnstown, PA"
	27900       "Joplin, MO"
	28020       "Kalamazoo-Portage, MI"
	28100       "Kankakee-Bradley, IL"
	28140       "Kansas City, MO-KS (Franklin, KS; Leavenworth, KS; Linn, KS; Bates, MO; and Caldwell, MO Counties not in sample)"
	28660       "Killeen-Temple-Fort Hood, TX"
	28700       "Kingsport-Bristol, TN-VA (Virginia portion not identified)"
	28740       "Kingston, NY"
	28940       "Knoxville, TN (Anderson County not in sample)"
	29100       "La Crosse, WI-MN (Houston County not in sample)"
	29180       "Lafayette, LA"
	29340       "Lake Charles, LA (Cameron Parish not in sample)"
	29460       "Lakeland-Winter Haven, FL"
	29540       "Lancaster, PA"
	29620       "Lansing-East Lansing, MI"
	29700       "Laredo, TX"
	29740       "Las Cruces, NM"
	29820       "Las Vegas-Paradise, NV"
	29940       "Lawrence, KS"
	30020       "Lawton, OK"
	30460       "Lexington-Fayette, KY"
	30780       "Little Rock-North Little Rock, AR (Perry County not in sample)"
	30980       "Longview, TX (Rusk and Upshur Counties not in sample)"
	31100       "Los Angeles-Long Beach-Santa Ana, CA"
	31140       "Louisville, KY-IN (Washington, IN; Henry, KY; Nelson, KY; Shelby, KY; and Trimble, KY Counties not in sample)"
	31180       "Lubbock, TX (Crosby County not in sample)"
	31340       "Lynchburg, VA (Appomattox and Bedford Counties and Bedford City not In sample)"
	31420       "Macon, GA (Crawford, Monroe, and Twiggs Counties not in sample)"
	31460       "Madera, CA"
	31540       "Madison, WI (Iowa County not in sample)"
	32580       "McAllen-Edinburg-Pharr, TX"
	32780       "Medford, OR"
	32820       "Memphis, TN-MS-AR (Arkansas portion not identified and Tunica County, MS not in sample)"
	32900       "Merced, CA"
	33100       "Miami-Fort Lauderdale-Miami Beach, FL"
	33140       "Michigan City-La Porte, IN"
	33260       "Midland, TX"
	33340       "Milwaukee-Waukesha-West Allis, WI"
	33460       "Minneapolis-St Paul-Bloomington, MN-WI (Wisconsin portion not identified)"
	33660       "Mobile, AL"
	33700       "Modesto, CA"
	33740       "Monroe, LA"
	33780       "Monroe, MI"
	33860       "Montgomery, AL"
	34740       "Muskegon-Norton Shores, MI"
	34820       "Myrtle Beach-Conway-North Myrtle Beach, SC"
	34900       "Napa, CA"
	34940       "Naples-Marco Island, FL"
	34980       "Nashville-Davidson-Murfreesboro, TN (Cannon, Hickman and Macon Counties not in sample)"
	35380       "New Orleans-Metairie-Kenner, LA"
	35620       "New York-Northern New Jersey-Long Island, NY-NJ-PA (Pennsylvania portion not in sample. White Plains central city recoded to balance of metropolitan)"
	35660       "Niles-Benton Harbor, MI"
	36100       "Ocala, FL"
	36140       "Ocean City, NJ"
	36260       "Ogden-Clearfield, UT"
	36420       "Oklahoma City, OK"
	36500       "Olympia, WA"
	36540       "Omaha-Council Bluffs, NE-IA"
	36740       "Orlando, FL"
	36780       "Oshkosh-Neenah, WI"
	37100       "Oxnard-Thousand Oaks-Ventura, CA"
	37340       "Palm Bay-Melbourne-Titusville, FL"
	37460       "Panama City-Lynn Haven, FL"
	37860       "Pensacola-Ferry Pass-Brent, FL"
	37900       "Peoria, IL"
	37980       "Philadelphia-Camden-Wilmington, PA-NJ-DE"
	38060       "Phoenix-Mesa-Scottsdale, AZ"
	38300       "Pittsburgh, PA"
	38900       "Portland-Vancouver-Beaverton, OR-WA (Yamhill County, OR not in sample)"
	38940       "Port St. Lucie-Fort Pierce, FL"
	39100       "Poughkeepsie-Newburgh-Middletown, NY"
	39140       "Prescott, AZ"
	39340       "Provo-Orem, UT (Juab County not in sample)"
	39380       "Pueblo, CO"
	39460       "Punta Gorda, FL"
	39540       "Racine, WI"
	39580       "Raleigh-Cary, NC"
	39740       "Reading, PA"
	39900       "Reno-Sparks, NV"
	40060       "Richmond, VA (Cumberland County not in sample)"
	40140       "Riverside-San Bernardino-Ontario, CA"
	40220       "Roanoke, VA (Craig and Franklin Counties not in sample)"
	40380       "Rochester, NY"
	40420       "Rockford, IL"
	40900       "Sacramento--Arden-Arcade-Roseville, CA"
	40980       "Saginaw-Saginaw Township North, MI"
	41060       "St. Cloud, MN"
	41180       "St. Louis, MO-IL (Calhoun County, IL not in sample)"
	41420       "Salem, OR"
	41500       "Salinas, CA"
	41540       "Salisbury, MD"
	41620       "Salt Lake City, UT (Tooele County not in sample)"
	41700       "San Antonio, TX"
	41740       "San Diego-Carlsbad-San Marcos, CA"
	41860       "San Francisco-Oakland-Fremont, CA"
	41940       "San Jose-Sunnyvale-Santa Clara, CA"
	42020       "San Luis Obispo-Paso Robles, CA"
	42060       "Santa Barbara-Santa Maria-Goleta, CA"
	42100       "Santa Cruz-Watsonville, CA"
	42140       "Santa Fe, NM"
	42220       "Santa Rosa-Petaluma, CA"
	42260       "Sarasota-Bradenton-Venice, FL"
	42340       "Savannah, GA"
	42540       "Scranton-Wilkes-Barre, PA"
	42660       "Seattle-Tacoma-Bellevue, WA"
	43340       "Shreveport-Bossier City, LA"
	43620       "Sioux Falls, SD"
	43780       "South Bend-Mishawaka, IN-MI (Michigan portion not identified)"
	43900       "Spartanburg, SC"
	44060       "Spokane, WA"
	44100       "Springfield, IL"
	44180       "Springfield, MO (Dallas and Polk Counties not in sample)"
	44220       "Springfield, OH"
	44700       "Stockton, CA"
	45060       "Syracuse, NY"
	45220       "Tallahassee, FL"
	45300       "Tampa-St. Petersburg-Clearwater, FL"
	45780       "Toledo, OH (Ottawa County not in sample)"
	45820       "Topeka, KS (Jackson and Jefferson Counties not in sample)"
	45940       "Trenton-Ewing, NJ"
	46060       "Tucson, AZ"
	46140       "Tulsa, OK (Okmulgee County not in sample)"
	46220       "Tuscaloosa, AL (Greene and Hale Counties not in sample)"
	46540       "Utica-Rome, NY"
	46660       "Valdosta, GA (Lanier County not in sample)"
	46700       "Vallejo-Fairfield, CA"
	46940       "Vero Beach, FL"
	47020       "Victoria, TX"
	47220       "Vineland-Millville-Bridgeton, NJ"
	47260       "Virginia Beach-Norfolk-Newport News, VA-NC (North Carolina portion not identified)"
	47300       "Visalia-Porterville, CA"
	47380       "Waco, TX"
	47580       "Warner Robins, GA"
	47900       "Washington-Arlington-Alexandria, DC-VA-MD-WV (West Virginia portion not identified. Reston central city recoded to balance of metropolitan.)"
	47940       "Waterloo-Cedar Falls, IA (Grundy County not in sample)"
	48140       "Wausau, WI"
	48620       "Wichita, KS"
	49180       "Winston-Salem, NC"
	49420       "Yakima, WA"
	49620       "York-Hanover, PA"
	49660       "Youngstown-Warren-Boardman, OH-PA (Pennsylvania portion not in sample)"
	70750       "Bangor, ME"
	70900       "Barnstable Town, MA"
	71650       "Boston-Cambridge-Quincy, MA-NH"
	71950       "Bridgeport-Stamford-Norwalk, CT"
	72400       "Burlington-South Burlington, VT"
	72850       "Danbury, CT"
	73450       "Hartford-West Hartford-East Hartford, CT"
	74500       "Leominster-Fitchburg-Gardner, MA"
	75700       "New Haven, CT"
	76450       "Norwich-New London, CT-RI (RI portion recoded to Providence NECTA)"
	76750       "Portland-South Portland, ME"
	77200       "Providence-Fall River-Warwick, RI-MA"
	77350       "Rochester-Dover, NH-ME (Maine portion not identified)"
	78100       "Springfield, MA-CT (Connecticut portion not identified)"
	78700       "Waterbury, CT"
	79600       "Worcester, MA-CT (Connecticut portion not identified)"
;
label values gtco     gtco;
label define gtco
	0           "NOT IDENTIFIED"
;
label values gtcbsast gtcbsast;
label define gtcbsast
	1           "PRINCIPAL CITY"
	2           "BALANCE"
	3           "NONMETROPOLITAN"
	4           "NOT IDENTIFIED"
;
label values gtmetsta gtmetsta;
label define gtmetsta
	1           "METROPOLITAN"
	2           "NONMETROPOLITAN"
	3           "NOT IDENTIFIED"
;
label values gtindvpc gtindvpc;
label define gtindvpc
	0           "NOT IDENTIFIED, NONMETROPOLITAN,"
;
label values gtcbsasz gtcbsasz;
label define gtcbsasz
	0           "NOT IDENTIFIED OR NONMETROPOLITAN"
	2           "100,000 - 249,999"
	3           "250,000 - 499,999"
	4           "500,000 - 999,999"
	5           "1,000,000 - 2,499,999"
	6           "2,500,000 - 4,999,999"
	7           "5,000,000+"
;
label values gtcsa    gtcsa;
label define gtcsa
	0           "NOT IDENTIFIED OR NONMETROPOLITAN"
;
label values perrp    perrp;
label define perrp
	1           "REFERENCE PERSON W/RELS."
	2           "REFERENCE PERSON W/O RELS."
	3           "SPOUSE"
	4           "CHILD"
	5           "GRANDCHILD"
	6           "PARENT"
	7           "BROTHER/SISTER"
	8           "OTHER REL. OR REF. PERSON"
	9           "FOSTER CHILD"
	10          "NONREL. OF REF. PERSON W/RELS."
	11          "NOT USED"
	12          "NONREL. OF REF. PERSON W/O RELS."
	13          "UNMARRIED PARTNER W/RELS."
	14          "UNMARRIED PARTNER W/OUT RELS."
	15          "HOUSEMATE/ROOMMATE W/RELS."
	16          "HOUSEMATE/ROOMMATE W/OUT RELS."
	17          "ROOMER/BOARDER W/RELS."
	18          "ROOMER/BOARDER W/OUT RELS."
;
label values peparent peparent;
label define peparent
	-1          "NO PARENT"
;
label values prtage   prtage;
label define prtage
	80          "80-84 Years Old"
	85          "85+ Years Old"
;
label values prtfage  prtfage;
label define prtfage
	0           "NO TOP CODE"
	1           "TOP CODED VALUE FOR AGE"
;
label values pemaritl pemaritl;
label define pemaritl
	1           "MARRIED - SPOUSE PRESENT"
	2           "MARRIED - SPOUSE ABSENT"
	3           "WIDOWED"
	4           "DIVORCED"
	5           "SEPARATED"
	6           "NEVER MARRIED"
;
label values pespouse pespouse;
label define pespouse
	-1          "NO SPOUSE"
;
label values pesex    pesex;
label define pesex
	1           "MALE"
	2           "FEMALE"
;
label values peafever peafever;
label define peafever
	1           "YES"
	2           "NO"
;
label values peafnow  peafnow;
label define peafnow
	1           "YES"
	2           "NO"
;
label values peeduca  peeduca;
label define peeduca
	31          "LESS THAN 1ST GRADE"
	32          "1ST, 2ND, 3RD OR 4TH GRADE"
	33          "5TH OR 6TH GRADE"
	34          "7TH OR 8TH GRADE"
	35          "9TH GRADE"
	36          "10TH GRADE"
	37          "11TH GRADE"
	38          "12TH GRADE NO DIPLOMA"
	39          "HIGH SCHOOL GRAD-DIPLOMA OR EQUIV (GED)"
	40          "SOME COLLEGE BUT NO DEGREE"
	41          "ASSOCIATE DEGREE-OCCUPATIONAL/VOCATIONAL"
	42          "ASSOCIATE DEGREE-ACADEMIC PROGRAM"
	43          "BACHELOR'S DEGREE (EX: BA, AB, BS)"
	44          "MASTER'S DEGREE (EX: MA, MS, MEng, MEd, MSW)"
	45          "PROFESSIONAL SCHOOL DEG (EX: MD, DDS, DVM)"
	46          "DOCTORATE DEGREE (EX: PhD, EdD)"
;
label values ptdtrace ptdtrace;
label define ptdtrace
	1           "White Only"
	2           "Black Only"
	3           "American Indian, Alaskan Native Only"
	4           "Asian Only"
	5           "Hawaiian/Pacific Islander Only"
	6           "White-Black"
	7           "White-AI"
	8           "White-Asian"
	9           "White-HP"
	10          "Black-AI"
	11          "Black-Asian"
	12          "Black-HP"
	13          "AI-Asian"
	14          "AI-HP"
	15          "Asian-HP"
	16          "W-B-AI"
	17          "W-B-A"
	18          "W-B-HP"
	19          "W-AI-A"
	20          "W-AI-HP"
	21          "W-A-HP"
	22          "B-AI-A"
	23          "W-B-AI-A"
	24          "W-AI-A-HP"
	25          "Other 3 Race Combinations"
	26          "Other 4 and 5 Race Combinations"
;
label values prdthsp  prdthsp;
label define prdthsp
	1           "Mexican"
	2           "Puerto Rican"
	3           "Cuban"
	4           "Dominican"
	5           "Salvadoran"
	6           "Central American, excluding Salvadoran"
	7           "South American"
	8           "Other Spanish"
;
label values puchinhh puchinhh;
label define puchinhh
	1           "PERSON ADDED"
	2           "PERSON ADDED - URE"
	3           "PERSON UNDELETED"
	4           "PERSON DIED"
	5           "DELETED FOR REASON OTHER THAN DEATH"
	6           "PERSON JOINED ARMED FORCES"
	7           "PERSON NO LONGER IN AF"
	9           "CHANGE IN DEMOGRAPHIC INFORMATION"
;
label values prfamnum prfamnum;
label define prfamnum
	0           "NOT A FAMILY MEMBER"
	1           "PRIMARY FAMILY MEMBER ONLY"
	2           "SUBFAMILY NO. 2 MEMBER"
	3           "SUBFAMILY NO. 3 MEMBER"
	4           "SUBFAMILY NO. 4 MEMBER"
	5           "SUBFAMILY NO. 5 MEMBER"
	6           "SUBFAMILY NO. 6 MEMBER"
	7           "SUBFAMILY NO. 7 MEMBER"
	8           "SUBFAMILY NO. 8 MEMBER"
	9           "SUBFAMILY NO. 9 MEMBER"
	10          "SUBFAMILY NO. 10 MEMBER"
	11          "SUBFAMILY NO. 11 MEMBER"
	12          "SUBFAMILY NO. 12 MEMBER"
	13          "SUBFAMILY NO. 13 MEMBER"
	14          "SUBFAMILY NO. 14 MEMBER"
	15          "SUBFAMILY NO. 15 MEMBER"
	16          "SUBFAMILY NO. 16 MEMBER"
	17          "SUBFAMILY NO. 17 MEMBER"
	18          "SUBFAMILY NO. 18 MEMBER"
	19          "SUBFAMILY NO. 19 MEMBER"
;
label values prfamrel prfamrel;
label define prfamrel
	0           "NOT A FAMILY MEMBER"
	1           "REFERENCE PERSON"
	2           "SPOUSE"
	3           "CHILD"
	4           "OTHER RELATIVE (PRIMARY FAMILY & UNREL)"
;
label values prfamtyp prfamtyp;
label define prfamtyp
	1           "PRIMARY FAMILY"
	2           "PRIMARY INDIVIDUAL"
	3           "RELATED SUBFAMILY"
	4           "UNRELATED SUBFAMILY"
	5           "SECONDARY INDIVIDUAL"
;
label values pehspnon pehspnon;
label define pehspnon
	1           "HISPANIC"
	2           "NON-HISPANIC"
;
label values prmarsta prmarsta;
label define prmarsta
	1           "MARRIED, CIVILIAN SPOUSE PRESENT"
	2           "MARRIED, ARMED FORCES SPOUSE PRESENT"
	3           "MARRIED, SPOUSE ABSENT (EXC. SEPARATED)"
	4           "WIDOWED"
	5           "DIVORCED"
	6           "SEPARATED"
	7           "NEVER MARRIED"
;
label values prpertyp prpertyp;
label define prpertyp
	1           "CHILD HOUSEHOLD MEMBER"
	2           "ADULT CIVILIAN HOUSEHOLD MEMBER"
	3           "ADULT ARMED FORCES HOUSEHOLD MEMBER"
;
label values penatvty penatvty;
label define penatvty
	57          "United States"
	60          "American Samoa"
	66          "Guam"
	69          "Northern Marianas"
	73          "Puerto Rico"
	78          "U. S. Virgin Islands"
	100         "Albania"
	102         "Austria"
	103         "Belgium"
	104         "Bulgaria"
	105         "Czechoslovakia"
	106         "Denmark"
	108         "Finland"
	109         "France"
	110         "Germany"
	116         "Greece"
	117         "Hungary"
	118         "Iceland"
	119         "Ireland"
	120         "Italy"
	126         "Netherlands"
	127         "Norway"
	128         "Poland"
	129         "Portugal"
	130         "Azores"
	132         "Romania"
	134         "Spain"
	136         "Sweden"
	137         "Switzerland"
	138         "United Kingdom"
	139         "England"
	140         "Scotland"
	142         "Northern Ireland"
	147         "Yugoslavia"
	148         "Czech Republic"
	149         "Slovakia"
	150         "Bosnia & Herzegovina"
	151         "Croatia"
	152         "Macedonia"
	154         "Serbia"
	155         "Estonia"
	156         "Latvia"
	157         "Lithuania"
	158         "Armenia"
	159         "Azerbaijan"
	160         "Belarus"
	161         "Georgia"
	162         "Moldova"
	163         "Russia"
	164         "Ukraine"
	165         "USSR"
	166         "Europe, not specified"
	168         "Montenegro"
	200         "Afghanistan"
	202         "Bangladesh"
	203         "Bhutan"
	205         "Myanmar (Burma)"
	206         "Cambodia"
	207         "China"
	209         "Hong Kong"
	210         "India"
	211         "Indonesia"
	212         "Iran"
	213         "Iraq"
	214         "Israel"
	215         "Japan"
	216         "Jordan"
	217         "Korea"
	218         "Kazakhstan"
	220         "South Korea"
	222         "Kuwait"
	223         "Laos"
	224         "Lebanon"
	226         "Malaysia"
	228         "Mongolia"
	229         "Nepal"
	231         "Pakistan"
	233         "Philippines"
	235         "Saudi Arabia"
	236         "Singapore"
	238         "Sri Lanka"
	239         "Syria"
	240         "Taiwan"
	242         "Thailand"
	243         "Turkey"
	245         "United Arab Emirates"
	246         "Uzbekistan"
	247         "Vietnam"
	248         "Yemen"
	249         "Asia, not specified"
	300         "Bermuda"
	301         "Canada"
	303         "Mexico"
	310         "Belize"
	311         "Costa Rica"
	312         "El Salvador"
	313         "Guatemala"
	314         "Honduras"
	315         "Nicaragua"
	316         "Panama"
	321         "Antigua and Barbuda"
	323         "Bahamas"
	324         "Barbados"
	327         "Cuba"
	328         "Dominica"
	329         "Dominican Republic"
	330         "Grenada"
	332         "Haiti"
	333         "Jamaica"
	338         "St. Kitts--Nevis"
	339         "St. Lucia"
	340         "St. Vincent and the Grenadines"
	341         "Trinidad and Tobago"
	343         "West Indies, not specified"
	360         "Argentina"
	361         "Bolivia"
	362         "Brazil"
	363         "Chile"
	364         "Columbia"
	365         "Ecuador"
	368         "Guyana"
	369         "Paraguay"
	370         "Peru"
	372         "Uruguay"
	373         "Venezuela"
	374         "South America, not specified"
	399         "Americas, not specified"
	400         "Algeria"
	407         "Cameroon"
	408         "Cape Verde"
	412         "Congo"
	414         "Egypt"
	416         "Ethiopia"
	417         "Eritrea"
	421         "Ghana"
	423         "Guinea"
	425         "Ivory Coast"
	427         "Kenya"
	429         "Liberia"
	430         "Libya"
	436         "Morocco"
	440         "Nigeria"
	444         "Senegal"
	447         "Sierra Leone"
	448         "Somalia"
	449         "South Africa"
	451         "Sudan"
	453         "Tanzania"
	454         "Togo"
	457         "Uganda"
	459         "Zaire"
	460         "Zambia"
	461         "Zimbabwe"
	462         "Africa, not specified"
	501         "Australia"
	508         "Fiji"
	511         "Marshall Islands"
	512         "Micronesia"
	515         "New Zealand"
	523         "Tonga"
	527         "Samoa"
	555         "Elsewhere"
;
label values pemntvty pemntvty;
label define pemntvty
	57          "UNITED STATES"
	60          "AM SAMOA"
	66          "GUAM"
	73          "PUERTO RICO"
	78          "U. S. VIRGIN ISLANDS"
	96          "OTHER U. S. ISLAND AREA"
	555         "ELSEWHERE"
;
label values pefntvty pefntvty;
label define pefntvty
	57          "UNITED STATES"
	60          "AM SAMOA"
	66          "GUAM"
	73          "PUERTO RICO"
	78          "U. S. VIRGIN ISLANDS"
	96          "OTHER U. S. ISLAND AREA"
	555         "ELSEWHERE"
;
label values prcitshp prcitshp;
label define prcitshp
	1           "NATIVE, BORN IN THE UNITED STATES"
	2           "NATIVE, BORN IN PUERTO RICO OR OTHER U.S. ISLAND AREAS"
	3           "NATIVE, BORN ABROAD OF AMERICAN PARENT OR PARENTS"
	4           "FOREIGN BORN, U.S. CITIZEN BY NATURALIZATION"
	5           "FOREIGN BORN, NOT A CITIZEN OF THE UNITED STATES"
;
label values prinusyr prinusyr;
label define prinusyr
	-1          "NOT IN UNIVERSE (BORN IN U.S.)"
	0           "NOT FOREIGN BORN"
	1           "BEFORE 1950"
	2           "1950-1959"
	3           "1960-1964"
	4           "1965-1969"
	5           "1970-1974"
	6           "1975-1979"
	7           "1980-1981"
	8           "1982-1983"
	9           "1984-1985"
	10          "1986-1987"
	11          "1988-1989"
	12          "1990-1991"
;
label values puslfprx puslfprx;
label define puslfprx
	1           "SELF"
	2           "PROXY"
	3           "BOTH SELF AND PROXY"
;
label values pemlr    pemlr;
label define pemlr
	1           "EMPLOYED-AT WORK"
	2           "EMPLOYED-ABSENT"
	3           "UNEMPLOYED-ON LAYOFF"
	4           "UNEMPLOYED-LOOKING"
	5           "NOT IN LABOR FORCE-RETIRED"
	6           "NOT IN LABOR FORCE-DISABLED"
	7           "NOT IN LABOR FORCE-OTHER"
;
label values puwk     puwk;
label define puwk
	1           "YES"
	2           "NO"
	3           "RETIRED"
	4           "DISABLED"
	5           "UNABLE TO WORK"
;
label values pubus1   pubus1l;
label define pubus1l
	1           "YES"
	2           "NO"
;
label values pubus2ot pubus2ot;
label define pubus2ot
	1           "YES"
	2           "NO"
;
label values pubusck1 pubuscka;
label define pubuscka
	1           "GOTO PUBUS1"
	2           "GOTO PURETCK1"
;
label values pubusck2 pubusckb;
label define pubusckb
	1           "GOTO PUHRUSL1"
	2           "GOTO PUBUS2"
;
label values pubusck3 pubusckc;
label define pubusckc
	1           "GOTO PUABSRSN"
	2           "GOTO PULAY"
;
label values pubusck4 pubusckd;
label define pubusckd
	1           "GOTO PUHRUSL1"
	2           "GOTO PUABSPD"
;
label values puretot  puretot;
label define puretot
	1           "YES"
	2           "NO"
	3           "WAS NOT RETIRED LAST MONTH"
;
label values pudis    pudis;
label define pudis
	1           "YES"
	2           "NO"
	3           "DID NOT HAVE DISABILITY LAST MONTH"
;
label values peret1   peret1l;
label define peret1l
	1           "YES"
	2           "NO"
	3           "HAS A JOB"
;
label values pudis1   pudis1l;
label define pudis1l
	1           "YES"
	2           "NO"
;
label values pudis2   pudis2l;
label define pudis2l
	1           "YES"
	2           "NO"
;
label values puabsot  puabsot;
label define puabsot
	1           "YES"
	2           "NO"
	3           "RETIRED"
	4           "DISABLED"
	5           "UNABLE TO WORK"
;
label values pulay    pulay;
label define pulay
	1           "YES"
	2           "NO"
	3           "RETIRED"
	4           "DISABLED"
	5           "UNABLE TO WORK"
;
label values peabsrsn peabsrsn;
label define peabsrsn
	1           "ON LAYOFF"
	2           "SLACK WORK/BUSINESS CONDITIONS"
	3           "WAITING FOR A NEW JOB TO BEGIN"
	4           "VACATION/PERSONAL DAYS"
	5           "OWN ILLNESS/INJURY/MEDICAL PROBLEMS"
	6           "CHILD CARE PROBLEMS"
	7           "OTHER FAMILY/PERSONAL OBLIGATION"
	8           "MATERNITY/PATERNITY LEAVE"
	9           "LABOR DISPUTE"
	10          "WEATHER AFFECTED JOB"
	11          "SCHOOL/TRAINING"
	12          "CIVIC/MILITARY DUTY"
	13          "DOES NOT WORK IN THE BUSINESS"
	14          "OTHER (SPECIFY)"
;
label values peabspdo peabspdo;
label define peabspdo
	1           "YES"
	2           "NO"
;
label values pemjot   pemjot;
label define pemjot
	1           "YES"
	2           "NO"
;
label values pemjnum  pemjnum;
label define pemjnum
	2           "2 JOBS"
	3           "3 JOBS"
	4           "4 OR MORE JOBS"
;
label values pehrusl1 pehrusla;
label define pehrusla
	-4          "HOURS VARY"
;
label values pehrusl2 pehruslb;
label define pehruslb
	-4          "HOURS VARY"
;
label values pehrftpt pehrftpt;
label define pehrftpt
	1           "YES"
	2           "NO"
	3           "HOURS VARY"
;
label values pehruslt pehruslt;
label define pehruslt
	-4          "VARIES"
;
label values pehrwant pehrwant;
label define pehrwant
	1           "YES"
	2           "NO"
	3           "REGULAR HOURS ARE FULL-TIME"
;
label values pehrrsn1 pehrrsna;
label define pehrrsna
	1           "SLACK WORK/BUSINESS CONDITIONS"
	2           "COULD ONLY FIND PART-TIME WORK"
	3           "SEASONAL WORK"
	4           "CHILD CARE PROBLEMS"
	5           "OTHER FAMILY/PERSONAL OBLIGATIONS"
	6           "HEALTH/MEDICAL LIMITATIONS"
	7           "SCHOOL/TRAINING"
	8           "RETIRED/SOCIAL SECURITY LIMIT ON EARNINGS"
	9           "FULL-TIME WORKWEEK IS LESS THAN 35 HRS"
	10          "OTHER - SPECIFY"
;
label values pehrrsn2 pehrrsnb;
label define pehrrsnb
	1           "CHILD CARE PROBLEMS"
	2           "OTHER FAMILY/PERSONAL OBLIGATIONS"
	3           "HEALTH/MEDICAL LIMITATIONS"
	4           "SCHOOL/TRAINING"
	5           "RETIRED/SOCIAL SECURITY LIMIT ON EARNINGS"
	6           "FULL-TIME WORKWEEK LESS THAN 35 HOURS"
	7           "OTHER - SPECIFY"
;
label values pehrrsn3 pehrrsnc;
label define pehrrsnc
	1           "SLACK WORK/BUSINESS CONDITIONS"
	2           "SEASONAL WORK"
	3           "JOB STARTED OR ENDED DURING WEEK"
	4           "VACATION/PERSONAL DAY"
	5           "OWN ILLNESS/INJURY/MEDICAL APPOINTMENT"
	6           "HOLIDAY (LEGAL OR RELIGIOUS)"
	7           "CHILD CARE PROBLEMS"
	8           "OTHER FAMILY/PERSONAL OBLIGATIONS"
	9           "LABOR DISPUTE"
	10          "WEATHER AFFECTED JOB"
	11          "SCHOOL/TRAINING"
	12          "CIVIC/MILITARY DUTY"
	13          "OTHER REASON"
;
label values puhroff1 puhroffa;
label define puhroffa
	1           "YES"
	2           "NO"
;
label values puhrot1  puhrot1l;
label define puhrot1l
	1           "YES"
	2           "NO"
;
label values pehravl  pehravl;
label define pehravl
	1           "YES"
	2           "NO"
;
label values puhrck1  puhrck1l;
label define puhrck1l
	1           "GOTO PUHRUSL2"
	2           "GOTO PUHRUSLT"
;
label values puhrck2  puhrck2l;
label define puhrck2l
	1           "IF ENTRY OF 1 IN MJ AND ENTRY OF D, R OR V IN HRUSL1 AND ENTRY OF D, R, V OR 0-34 IN HRUSL2 GOTO HRFTPT"
	2           "IF ENTRY OF 1 IN MJ AND ENTRY OF D, R OR V IN HRUSL2 AND ENTRY OF D, R V OR 0-34 IN HRUSL1 GOTO HRFTPT"
	3           "IF ENTRY OF 2, D OR R IN MJ AND ENTRY OF D, R OR V IN HRUSL1 GOTO HRFTPT"
	4           "IF ENTRY OF 1 IN BUS1 AND ENTRY OF D, R OR V IN HRUSL1 THEN GOTO HRFTPT"
	5           "ALL OTHERS GOTO HRCK3-C"
;
label values puhrck3  puhrck3l;
label define puhrck3l
	1           "IF ENTRY OF 1 IN ABSOT OR (ENTRY OR 2 IN ABSOT AND ENTRY OF 1 IN BUS AND CURRENT R_P EQUALS BUSLST) THEN GOTO HRCK8"
	2           "IF ENTRY OF 3 IN RET1 GOTO HRCK8"
	3           "IF ENTRY IN HRUSLT IS 0-34 HOURS GOTO HRCK4-C"
	4           "IF ENTRY IN HRUSLT IS 35+ GOTO HROFF1"
	5           "ALL OTHERS GOTO HRCK4-C"
	6           "GOTO PUHRCK4"
;
label values puhrck4  puhrck4l;
label define puhrck4l
	1           "IF ENTRY OF 1, D, R OR V IN HRFTPT THEN GOTO HRACT1"
	2           "IF ENTRY OF 2, D OR R IN BUS2 THEN GOTO HROFF1"
	3           "IF HRUSLT IS 0-34 THEN GOTO HRWANT"
	4           "IF ENTRY OF 2 IN HRFTPT THEN GOTO HRWANT"
	5           "ALL OTHERS GOTO HRACT1"
;
label values puhrck5  puhrck5l;
label define puhrck5l
	1           "IF ENTRY OF 1 IN MJOT GOTO HRACT2"
	2           "ALL OTHERS GOTO HRCK6-C"
;
label values puhrck6  puhrck6l;
label define puhrck6l
	1           "IF HRACT1 AND HRACT2 EQ 0 AND ENTRY OF 2, D, R IN BUS2 THEN GOTO LK"
	2           "IF HRACT1 AND HRACT2 EQ 0 THEN STORE 1 IN ABSOT AND GOTO ABSRSN"
	3           "ALL OTHERS GOTO HRACTT-C"
;
label values puhrck7  puhrck7l;
label define puhrck7l
	1           "(IF ENTRY OF 2, D OR R IN BUS2) AND (HRACT1 LESS THAN 15 OR D) GOTO HRCK8"
	2           "(IF ENTRY OF 2, D OR R IN BUS2) AND (HRACT1 IS 15+) GOTO HRCK8"
	3           "(IF HRUSLT IS 35+ OR IF ENTRY OF 1 IN HRFTPT) AND (HRACTT <35) AND ENTRY IN HRACT1 OR HRACT2 ISN'T D OR R THEN GOTO HRRSN3"
	4           "IF ENTRY OF 1 IN HRWANT AND HRACTT <35 AND (ENTRY OF 1, 2, 3 IN HRRSN1) GOTO HRAVL"
	5           "ALL OTHERS GOTO HRCK8"
;
label values puhrck12 puhrck1b;
label define puhrck1b
	1           "IF ENTRY OF 2, D OR R IN BUS2 AND HRACTT IS LESS THAN 15 OR D GOTO LK"
	2           "ALL OTHERS GOTO IOCK1"
;
label values pulaydt  pulaydt;
label define pulaydt
	1           "YES"
	2           "NO"
;
label values pulay6m  pulay6m;
label define pulay6m
	1           "YES"
	2           "NO"
;
label values pelayavl pelayavl;
label define pelayavl
	1           "YES"
	2           "NO"
;
label values pulayavr pulayavr;
label define pulayavr
	1           "OWN TEMPORARY ILLNESS"
	2           "GOING TO SCHOOL"
	3           "OTHER"
;
label values pelaylk  pelaylk;
label define pelaylk
	1           "YES"
	2           "NO"
;
label values pelaydur pelaydur;
label define pelaydur
	52          "52 weeks or more"
;
label values pelayfto pelayfto;
label define pelayfto
	1           "YES"
	2           "NO"
;
label values pulayck1 pulaycka;
label define pulaycka
	1           "GOTO PULAYCK3"
	2           "GOTO PULAYFT"
	3           "GOTO PULAYDR"
;
label values pulayck2 pulayckb;
label define pulayckb
	1           "GOTO PULAYDR3"
	2           "GOTO PULAYFT"
;
label values pulayck3 pulayckc;
label define pulayckc
	1           "MISCK = 5 GOTO IO1INT"
	2           "I-ICR = 1 OR I-OCR = 1, GOTO IO1INT"
	3           "ALL OTHERS GOTO SCHCK"
;
label values pulk     pulk;
label define pulk
	1           "YES"
	2           "NO"
	3           "RETIRED"
	4           "DISABLED"
	5           "UNABLE TO WORK"
;
label values pelkm1   pelkm1l;
label define pelkm1l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PUBLIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	12          "NOTHING"
	13          "OTHER PASSIVE"
;
label values pulkm2   pulkm2l;
label define pulkm2l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PUBLIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkm3   pulkm3l;
label define pulkm3l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PUBLIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkm4   pulkm4l;
label define pulkm4l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PUBLIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkm5   pulkm5l;
label define pulkm5l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PUBLIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkm6   pulkm6l;
label define pulkm6l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PUBLIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkdk1  pulkdk1l;
label define pulkdk1l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PUBLIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	12          "NOTHING"
	13          "OTHER PASSIVE"
;
label values pulkdk2  pulkdk2l;
label define pulkdk2l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PUBLIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkdk3  pulkdk3l;
label define pulkdk3l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PUBLIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkdk4  pulkdk4l;
label define pulkdk4l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PUBLIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkdk5  pulkdk5l;
label define pulkdk5l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PUBLIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkdk6  pulkdk6l;
label define pulkdk6l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PUBLIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkps1  pulkps1l;
label define pulkps1l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PUBLIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	12          "NOTHING"
	13          "OTHER PASSIVE"
;
label values pulkps2  pulkps2l;
label define pulkps2l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PUBLIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkps3  pulkps3l;
label define pulkps3l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PUBLIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkps4  pulkps4l;
label define pulkps4l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PUBLIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkps5  pulkps5l;
label define pulkps5l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PUBLIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pulkps6  pulkps6l;
label define pulkps6l
	1           "CONTACTED EMPLOYER DIRECTLY/INTERVIEW"
	2           "CONTACTED PUBLIC EMPLOYMENT AGENCY"
	3           "CONTACTED PRIVATE EMPLOYMENT AGENCY"
	4           "CONTACTED FRIENDS OR RELATIVES"
	5           "CONTACTED SCHOOL/UNIVERSITY EMPL CENTER"
	6           "SENT OUT RESUMES/FILLED OUT APPLICATION"
	7           "CHECKED UNION/PROFESSIONAL REGISTERS"
	8           "PLACED OR ANSWERED ADS"
	9           "OTHER ACTIVE"
	10          "LOOKED AT ADS"
	11          "ATTENDED JOB TRAINING PROGRAMS/COURSES"
	13          "OTHER PASSIVE"
;
label values pelkavl  pelkavl;
label define pelkavl
	1           "YES"
	2           "NO"
;
label values pulkavr  pulkavr;
label define pulkavr
	1           "WAITING FOR NEW JOB TO BEGIN"
	2           "OWN TEMPORARY ILLNESS"
	3           "GOING TO SCHOOL"
	4           "OTHER - SPECIFY"
;
label values pelkll1o pelkll1o;
label define pelkll1o
	1           "WORKING"
	2           "SCHOOL"
	3           "LEFT MILITARY SERVICE"
	4           "SOMETHING ELSE"
;
label values pelkll2o pelkll2o;
label define pelkll2o
	1           "LOST JOB"
	2           "QUIT JOB"
	3           "TEMPORARY JOB ENDED"
;
label values pelklwo  pelklwo;
label define pelklwo
	1           "WITHIN THE LAST 12 MONTHS"
	2           "MORE THAN 12 MONTHS AGO"
	3           "NEVER WORKED"
;
label values pelkdur  pelkdur;
label define pelkdur
	119         "119 or more weeks looking"
;
label values pelkfto  pelkfto;
label define pelkfto
	1           "YES"
	2           "NO"
	3           "DOESN'T MATTER"
;
label values pedwwnto pedwwnto;
label define pedwwnto
	1           "YES, OR MAYBE, IT DEPENDS"
	2           "NO"
	3           "RETIRED"
	4           "DISABLED"
	5           "UNABLE"
;
label values pedwrsn  pedwrsn;
label define pedwrsn
	1           "BELIEVES NO WORK AVAILABLE IN AREA OF EXPERTISE"
	2           "COULDN'T FIND ANY WORK"
	3           "LACKS NECESSARY SCHOOLING/TRAINING"
	4           "EMPLOYERS THINK TOO YOUNG OR TOO OLD"
	5           "OTHER TYPES OF DISCRIMINATION"
	6           "CAN'T ARRANGE CHILD CARE"
	7           "FAMILY RESPONSIBILITIES"
	8           "IN SCHOOL OR OTHER TRAINING"
	9           "ILL-HEALTH, PHYSICAL DISABILITY"
	10          "TRANSPORTATION PROBLEMS"
	11          "OTHER - SPECIFY"
;
label values pedwlko  pedwlko;
label define pedwlko
	1           "YES"
	2           "NO"
;
label values pedwwk   pedwwk;
label define pedwwk
	1           "YES"
	2           "NO"
;
label values pedw4wk  pedw4wk;
label define pedw4wk
	1           "YES"
	2           "NO"
;
label values pedwlkwk pedwlkwk;
label define pedwlkwk
	1           "YES"
	2           "NO"
;
label values pedwavl  pedwavl;
label define pedwavl
	1           "YES"
	2           "NO"
;
label values pedwavr  pedwavr;
label define pedwavr
	1           "OWN TEMPORARY ILLNESS"
	2           "GOING TO SCHOOL"
	3           "OTHER"
;
label values pudwck1  pudwck1l;
label define pudwck1l
	1           "IF ENTRY OF 2 IN BUS2 GOTO PUSCHCK"
	2           "IF ENTRY OF 3 ON ABSRSN GOTO PUNLFCK1"
	3           "IF ENTRY OF 1 IN RET1, STORE 1 IN DWWNTO"
	4           "ALL OTHERS GOTO PUDWWNT"
;
label values pudwck2  pudwck2l;
label define pudwck2l
	1           "IF ENTRY IN DIS1 OR DIS2 GOTO PUJHCK1-C"
	2           "IF ENTRY OF 4 IN DWWNT GOTO PUDIS1"
	3           "IF ENTRY OF 5 IN DWWNT GOTO PUDIS2"
	4           "ALL OTHERS GOTO PUDWCK4"
;
label values pudwck3  pudwck3l;
label define pudwck3l
	1           "IF AGERNG EQUALS 1-4 OR 9 GOTO PUDWCK4"
	2           "ALL OTHERS GOTO PUNLFCK2"
;
label values pudwck4  pudwck4l;
label define pudwck4l
	1           "IF ENTRY OF 10 AND/OR 11 AND/OR 13 ONLY IN LKM1-LKM3 GOTO PUDWCK5"
	2           "IF ENTRY OF 10 AND/OR 11 AND/OR 13 ONLY IN LKDK1-LKDK3 GOTO PUDWCK5"
	3           "IF ENTRY OF 10 AND/OR 11 AND/OR 13 ONLY IN LKPS1-LKPS3 GOTO PUDWCK5"
	4           "ALL OTHERS GOTO PUDWRSN"
;
label values pudwck5  pudwck5l;
label define pudwck5l
	1           "IF ENTRY OF 1 IN LK THEN STORE 1 IN DWLKO AND GOTO PUDWWK"
	2           "ALL OTHERS GOTO PUDWLK"
;
label values pejhwko  pejhwko;
label define pejhwko
	1           "YES"
	2           "NO"
;
label values pujhdp1o pujhdp1o;
label define pujhdp1o
	1           "YES"
	2           "NO"
;
label values pejhrsn  pejhrsn;
label define pejhrsn
	1           "PERSONAL/FAMILY (INCLUDING PREGNANCY)"
	2           "RETURN TO SCHOOL"
	3           "HEALTH"
	4           "RETIREMENT OR OLD AGE"
	5           "TEMP, SEASONAL OR INTERMITTENT JOB COMPLETE"
	6           "SLACK WORK/BUSINESS CONDITIONS"
	7           "UNSATISFACTORY WORK ARRANGEMENTS (HRS, PAY, ETC.)"
	8           "OTHER - SPECIFY"
;
label values pejhwant pejhwant;
label define pejhwant
	1           "YES, OR IT DEPENDS"
	2           "NO"
;
label values pujhck1  pujhck1l;
label define pujhck1l
	1           "PURET1 = 1, -2, OR -3 THEN GOTO NLFCK2"
	2           "IF MISCK EQUALS 4 OR 8 THEN GOTO PUJHCK2"
	3           "ALL OTHERS GOTO PUNLFCK1"
;
label values pujhck2  pujhck2l;
label define pujhck2l
	1           "IF ENTRY OF 1 IN DWWK AND I-MLR= 3, 4 THEN STORE 1 IN JHWKO, STORE DW4WK IN JHDP1O AND GOTO PUJHRSN"
	2           "IF ENTRY OF 2, D OR R IN DWWK THEN STORE DWWK IN JHWKO AND GOTO PUJHWANT"
	3           "ALL OTHERS GOTO PUJHWK"
;
label values prabsrea prabsrea;
label define prabsrea
	1           "FT PAID-VACATION"
	2           "FT PAID-OWN ILLNESS"
	3           "FT PAID-CHILD CARE PROBLEMS"
	4           "FT PAID-OTHER FAMILY/PERSONAL OBLIG."
	5           "FT PAID-MATERNITY/PATERNITY LEAVE"
	6           "FT PAID-LABOR DISPUTE"
	7           "FT PAID-WEATHER AFFECTED JOB"
	8           "FT PAID-SCHOOL/TRAINING"
	9           "FT PAID-CIVIC/MILITARY DUTY"
	10          "FT PAID-OTHER"
	11          "FT UNPAID-VACATION"
	12          "FT UNPAID-OWN ILLNESS"
	13          "FT UNPAID-CHILD CARE PROBLEMS"
	14          "FT UNPAID-OTHER FAM/PERSONAL OBLIGATION"
	15          "FT UNPAID-MATERNITY/PATERNITY LEAVE"
	16          "FT UNPAID-LABOR DISPUTE"
	17          "FT UNPAID-WEATHER AFFECTED JOB"
	18          "FT UNPAID-SCHOOL/TRAINING"
	19          "FT UNPAID-CIVIC/MILITARY DUTY"
	20          "FT UNPAID-OTHER"
	21          "PT PAID-VACATION"
	22          "PT PAID-OWN ILLNESS"
	23          "PT PAID-CHILD CARE PROBLEMS"
	24          "PT PAID-OTHER FAMILY/PERSONAL OBLIG."
	25          "PT PAID-MATERNITY/PATERNITY LEAVE"
	26          "PT PAID-LABOR DISPUTE"
	27          "PT PAID-WEATHER AFFECTED JOB"
	28          "PT PAID-SCHOOL/TRAINING"
	29          "PT PAID-CIVIC/MILITARY DUTY"
	30          "PT PAID-OTHER"
	31          "PT UNPAID-VACATION"
	32          "PT UNPAID-OWN ILLNESS"
	33          "PT UNPAID-CHILD CARE PROBLEMS"
	34          "PT UNPAID-OTHER FAM/PERSONAL OBLIGATION"
	35          "PT UNPAID-MATERNITY/PATERNITY LEAVE"
	36          "PT UNPAID-LABOR DISPUTE"
	37          "PT UNPAID-WEATHER AFFECTED JOB"
	38          "PT UNPAID-SCHOOL/TRAINING"
	39          "PT UNPAID-CIVIC/MILITARY DUTY"
	40          "PT UNPAID-OTHER"
;
label values prcivlf  prcivlf;
label define prcivlf
	1           "IN CIVILIAN LABOR FORCE"
	2           "NOT IN CIVILIAN LABOR FORCE"
;
label values prdisc   prdisc;
label define prdisc
	1           "DISCOURAGED WORKER"
	2           "CONDITIONALLY INTERESTED"
	3           "NOT AVAILABLE"
;
label values premphrs premphrs;
label define premphrs
	0           "UNEMPLOYED AND NILF"
	1           "W/JOB, NOT AT WORK-ILLNES"
	2           "W/JOB, NOT AT WORK-VACATION"
	3           "W/JOB, NOT AT WORK-WEATHER AFFECTED JOB"
	4           "W/JOB, NOT AT WORK-LABOR DISPUTE"
	5           "W/JOB, NOT AT WORK-CHILD CARE PROBLEMS"
	6           "W/JOB, NOT AT WORK-FAM/PERS OBLIGATION"
	7           "W/JOB, NOT AT WORK-MATERNITY/PATERNITY"
	8           "W/JOB, NOT AT WORK-SCHOOL/TRAINING"
	9           "W/JOB, NOT AT WORK-CIVIC/MILITARY DUTY"
	10          "W/JOB, NOT AT WORK-DOES NOT WORK IN BUS"
	11          "W/JOB, NOT AT WORK-OTHER"
	12          "AT WORK- 1-4 HRS"
	13          "AT WORK- 5-14 HRS"
	14          "AT WORK- 15-21 HRS"
	15          "AT WORK- 22-29 HRS"
	16          "AT WORK- 30-34 HRS"
	17          "AT WORK- 35-39 HRS"
	18          "AT WORK- 40 HRS"
	19          "AT WORK- 41-47 HRS"
	20          "AT WORK- 48 HRS"
	21          "AT WORK- 49-59 HRS"
	22          "AT WORK- 60 HRS OR MORE"
;
label values prempnot prempnot;
label define prempnot
	1           "EMPLOYED"
	2           "UNEMPLOYED"
	3           "NOT IN LABOR FORCE (NILF)-discouraged"
	4           "NOT IN LABOR FORCE (NILF)-other"
;
label values prexplf  prexplf;
label define prexplf
	1           "EMPLOYED"
	2           "UNEMPLOYED"
;
label values prftlf   prftlf;
label define prftlf
	1           "FULL TIME LABOR FORCE"
	2           "PART TIME LABOR FORCE"
;
label values prhrusl  prhrusl;
label define prhrusl
	1           "0-20 HRS"
	2           "21-34 HRS"
	3           "35-39 HRS"
	4           "40 HRS"
	5           "41-49 HRS"
	6           "50 OR MORE HRS"
	7           "VARIES-FULL TIME"
	8           "VARIES-PART TIME"
;
label values prjobsea prjobsea;
label define prjobsea
	1           "LOOKED LAST 12 MONTHS, SINCE COMPLETING PREVIOUS JOB"
	2           "LOOKED AND WORKED IN THE LAST 4 WEEKS"
	3           "LOOKED LAST 4 WEEKS - LAYOFF"
	4           "UNAVAILABLE JOB SEEKERS"
	5           "NO RECENT JOB SEARCH"
;
label values prpthrs  prpthrs;
label define prpthrs
	0           "USUALLY FT, PT FOR NONECONOMIC REASONS"
	1           "USUALLY.FT, PT ECON REASONS; 1-4 HRS"
	2           "USUALLY.FT, PT ECON REASONS; 5-14 HRS"
	3           "USUALLY.FT, PT ECON REASONS; 15-29 HRS"
	4           "USUALLY.FT, PT ECON REASONS; 30-34 HRS"
	5           "USUALLY.PT, ECON REASONS; 1-4 HRS"
	6           "USUALLY.PT, ECON REASONS; 5-14 HRS"
	7           "USUALLY.PT, ECON REASONS; 15-29 HRS"
	8           "USUALLY.PT, ECON REASONS; 30-34 HRS"
	9           "USUALLY.PT, NON-ECON REASONS; 1-4 HRS"
	10          "USUALLY.PT, NON-ECON REASONS; 5-14 HRS"
	11          "USUALLY.PT, NON-ECON REASONS; 15-29 HRS"
	12          "USUALLY.PT, NON-ECON REASONS; 30-34 HRS"
;
label values prptrea  prptrea;
label define prptrea
	1           "USU. FT-SLACK WORK/BUSINESS CONDITIONS"
	2           "USU. FT-SEASONAL WORK"
	3           "USU. FT-JOB STARTED/ENDED DURING WEEK"
	4           "USU. FT-VACATION/PERSONAL DAY"
	5           "USU. FT-OWN ILLNESS/INJURY/MEDICAL APPOINTMENT"
	6           "USU. FT-HOLIDAY (RELIGIOUS OR LEGAL)"
	7           "USU. FT-CHILD CARE PROBLEMS"
	8           "USU. FT-OTHER FAM/PERS OBLIGATIONS"
	9           "USU. FT-LABOR DISPUTE"
	10          "USU. FT-WEATHER AFFECTED JOB"
	11          "USU. FT-SCHOOL/TRAINING"
	12          "USU. FT-CIVIC/MILITARY DUTY"
	13          "USU. FT-OTHER REASON"
	14          "USU. PT-SLACK WORK/BUSINESS CONDITIONS"
	15          "USU. PT-COULD ONLY FIND PT WORK"
	16          "USU. PT-SEASONAL WORK"
	17          "USU. PT-CHILD CARE PROBLEMS"
	18          "USU. PT-OTHER FAM/PERS OBLIGATIONS"
	19          "USU. PT-HEALTH/MEDICAL LIMITATIONS"
	20          "USU. PT-SCHOOL/TRAINING"
	21          "USU. PT-RETIRED/S.S. LIMIT ON EARNINGS"
	22          "USU. PT-WORKWEEK <35 HOURS"
	23          "USU. PT-OTHER REASON"
;
label values pruntype pruntype;
label define pruntype
	1           "JOB LOSER/ON LAYOFF"
	2           "OTHER JOB LOSER"
	3           "TEMPORARY JOB ENDED"
	4           "JOB LEAVER"
	5           "RE-ENTRANT"
	6           "NEW-ENTRANT"
;
label values prwksch  prwksch;
label define prwksch
	0           "NOT IN LABOR FORCE"
	1           "AT WORK"
	2           "WITH JOB, NOT AT WORK"
	3           "UNEMPLOYED, SEEKS FT"
	4           "UNEMPLOYED, SEEKS PT"
;
label values prwkstat prwkstat;
label define prwkstat
	1           "NOT IN LABOR FORCE"
	2           "FT HOURS (35+), USUALLY FT"
	3           "PT FOR ECONOMIC REASONS, USUALLY FT"
	4           "PT FOR NON-ECONOMIC REASONS, USUALLY FT"
	5           "NOT AT WORK, USUALLY FT"
	6           "PT HRS, USUALLY PT FOR ECONOMIC REASONS"
	7           "PT HRS, USUALLY PT FOR NON-ECONOMIC REASONS"
	8           "FT HOURS, USUALLY PT FOR ECONOMIC REASONS"
	9           "FT HOURS, USUALLY PT FOR NON-ECONOMIC"
	10          "NOT AT WORK, USUALLY PART-TIME"
	11          "UNEMPLOYED FT"
	12          "UNEMPLOYED PT"
;
label values prwntjob prwntjob;
label define prwntjob
	1           "WANT A JOB"
	2           "OTHER NOT IN LABOR FORCE"
;
label values pujhck3  pujhck3l;
label define pujhck3l
	1           "IF I-MLR EQ 3 OR 4 THEN GOTO PUJHDP1"
	2           "ALL OTHERS GOTO PUJHRSN"
;
label values pujhck4  pujhck4l;
label define pujhck4l
	1           "IF ENTRY OF 2, D OR R IN PUDW4WK OR IN PUJHDP1O THEN GOTO PUJHCK5"
	2           "IF ENTRY OF 1 IN PUDW4WK OR IN PUJHDP10 THEN GOTO PUIO1INT"
	3           "IF I-MLR EQUALS 1 OR 2 AND ENTRY IN PUJHRSN THEN GOTO PUJHCK5"
	4           "IF ENTRY IN PUJHRSN THEN GOTO PUIO1INT"
	5           "ALL OTHERS GOTO PUNLFCK1"
;
label values pujhck5  pujhck5l;
label define pujhck5l
	1           "IF I-IO1ICR EQUALS 1 OR I-IO1OCR EQUALS 1 THEN GOTO PUIO1INT"
	2           "ALL OTHERS GOTO PUIOCK5"
;
label values puiodp1  puiodp1l;
label define puiodp1l
	1           "YES"
	2           "NO"
;
label values puiodp2  puiodp2l;
label define puiodp2l
	1           "YES"
	2           "NO"
;
label values puiodp3  puiodp3l;
label define puiodp3l
	1           "YES"
	2           "NO"
;
label values peio1cow peio1cow;
label define peio1cow
	1           "GOVERNMENT - FEDERAL"
	2           "GOVERNMENT - STATE"
	3           "GOVERNMENT - LOCAL"
	4           "PRIVATE, FOR PROFIT"
	5           "PRIVATE, NONPROFIT"
	6           "SELF-EMPLOYED, INCORPORATED"
	7           "SELF-EMPLOYED, UNINCORPORATED"
	8           "WITHOUT PAY"
;
label values puio1mfg puio1mfg;
label define puio1mfg
	1           "MANUFACTURING"
	2           "RETAIL TRADE"
	3           "WHOLESALE TRADE"
	4           "SOMETHING ELSE"
;
label values peio2cow peio2cow;
label define peio2cow
	1           "GOVERNMENT - FEDERAL"
	2           "GOVERNMENT - STATE"
	3           "GOVERNMENT - LOCAL"
	4           "PRIVATE, FOR PROFIT"
	5           "PRIVATE, NONPROFIT"
	6           "SELF-EMPLOYED, INCORPORATED"
	7           "SELF-EMPLOYED, UNINCORPORATED"
	8           "WITHOUT PAY"
;
label values puio2mfg puio2mfg;
label define puio2mfg
	1           "MANUFACTURING"
	2           "RETAIL TRADE"
	3           "WHOLESALE TRADE"
	4           "SOMETHING ELSE"
;
label values puiock1  puiock1l;
label define puiock1l
	1           "IF {MISCK EQ 1 OR 5) OR MISCK EQ 2-4, 6-8 AND I-MLR EQ 3-7) AND ENTRY OF 1 IN ABS} THEN GOTO PUIO1INT"
	2           "IF (MISCK EQ 1 OR 5) OR {(MISCK EQ 2-4, 6-8 AND I-MLR EQ 3-7) AND ( ENTRY OF 1 IN WK OR HRCK7-C IS BLANK, 1-3)} GOTO PUIO1INT"
	3           "IF I-IO1NAM IS D, R OR BLANK THEN GOTO PUIO1INT"
	4           "ALL OTHERS GOTO PUIODP1"
;
label values puiock2  puiock2l;
label define puiock2l
	1           "IF I-IO1ICR EQ 1 THEN GOTO PUIO1IND"
	2           "IF I-IO1OCR EQ 1 THEN GOTO PUIO1OCC"
	3           "ALL OTHERS GOTO PUIODP2"
;
label values puiock3  puiock3l;
label define puiock3l
	1           "IF I-IO1OCC EQUALS D, R OR BLANK THEN GOTO PUIO1OCC"
	2           "IF I-IO1DT1 IS D, R OR BLANK THEN GOTO PUIO1OCC"
	3           "ALL OTHERS GOTO PUIODP3"
;
label values prioelg  prioelg;
label define prioelg
	0           "NOT ELIGIBLE FOR EDIT"
	1           "ELIGIBLE FOR EDIT"
;
label values pragna   pragna;
label define pragna
	1           "AGRICULTURAL"
	2           "NON-AGRICULTURAL"
;
label values prcow1   prcow1l;
label define prcow1l
	1           "FEDERAL GOVT"
	2           "STATE GOVT"
	3           "LOCAL GOVT"
	4           "PRIVATE (INCL. SELF-EMPLOYED INCORP.)"
	5           "SELF-EMPLOYED, UNINCORP."
	6           "WITHOUT PAY"
;
label values prcow2   prcow2l;
label define prcow2l
	1           "FEDERAL GOVT"
	2           "STATE GOVT"
	3           "LOCAL GOVT"
	4           "PRIVATE (INCL. SELF-EMPLOYED INCORP.)"
	5           "SELF-EMPLOYED, UNINCORP."
	6           "WITHOUT PAY"
;
label values prcowpg  prcowpg;
label define prcowpg
	1           "PRIVATE"
	2           "GOVERNMENT"
;
label values prdtcow1 prdtcowa;
label define prdtcowa
	1           "AGRI., WAGE & SALARY, PRIVATE"
	2           "AGRI., WAGE & SALARY, GOVERNMENT"
	3           "AGRI., SELF-EMPLOYED"
	4           "AGRI., UNPAID"
	5           "NONAG, WS, PRIVATE, PRIVATE HHLDS"
	6           "NONAG, WS, PRIVATE, OTHER PRIVATE"
	7           "NONAG, WS, GOVT, FEDERAL"
	8           "NONAG, WS, GOVT, STATE"
	9           "NONAG, WS, GOVT, LOCAL"
	10          "NONAG, SELF-EMPLOYED"
	11          "NONAG, UNPAID"
;
label values prdtcow2 prdtcowb;
label define prdtcowb
	1           "AGRI., WAGE & SALARY, PRIVATE"
	2           "AGRI., WAGE & SALARY, GOVERNMENT"
	3           "AGRI., SELF-EMPLOYED"
	4           "AGRI., UNPAID"
	5           "NONAG, WS, PRIVATE, PRIVATE HHLDS"
	6           "NONAG, WS, PRIVATE, OTHER PRIVATE"
	7           "NONAG, WS, GOVT, FEDERAL"
	8           "NONAG, WS, GOVT, STATE"
	9           "NONAG, WS, GOVT, LOCAL"
	10          "NONAG, SELF-EMPLOYED"
	11          "NONAG, UNPAID"
;
label values prdtind1 prdtinda;
label define prdtinda
	1           "Agriculture"
	2           "Forestry, logging, fishing, hunting, and trapping"
	3           "Mining"
	4           "Construction"
	5           "Nonmetallic mineral product manufacturing"
	6           "Primary metals and fabricated metal products"
	7           "Machinery manufacturing"
	8           "Computer and electronic product manufacturing"
	9           "Electrical equipment, appliance manufacturing"
	10          "Transportation equipment manufacturing"
	11          "Wood products"
	12          "Furniture and fixtures manufacturing"
	13          "Miscellaneous and not specified manufacturing"
	14          "Food manufacturing"
	15          "Beverage and tobacco products"
	16          "Textile, apparel, and leather manufacturing"
	17          "Paper and printing"
	18          "Petroleum and coal products manufacturing"
	19          "Chemical manufacturing"
	20          "Plastics and rubber products"
	21          "Wholesale trade"
	22          "Retail trade"
	23          "Transportation and warehousing"
	24          "Utilities"
	25          "Publishing industries (except internet)"
	26          "Motion picture and sound recording industries"
	27          "Broadcasting (except internet)"
	28          "Internet publishing and broadcasting"
	29          "Telecommunications"
	30          "Internet service providers and data processing services"
	31          "Other information services"
	32          "Finance"
	33          "Insurance"
	34          "Real estate"
	35          "Rental and leasing services"
	36          "Professional and technical services"
	37          "Management of companies and enterprises"
	38          "Administrative and support services"
	39          "Waste management and remediation services"
	40          "Educational services"
	41          "Hospitals"
	42          "Health care services, except hospitals"
	43          "Social assistance"
	44          "Arts, entertainment, and recreation"
	45          "Accommodation"
	46          "Food services and drinking places"
	47          "Repair and maintenance"
	48          "Personal and laundry services"
	49          "Membership associations and organizations"
	50          "Private households"
	51          "Public administration"
	52          "Armed forces"
;
label values prdtind2 prdtindb;
label define prdtindb
	1           "Agriculture"
	2           "Forestry, logging, fishing, hunting, and trapping"
	3           "Mining"
	4           "Construction"
	5           "Nonmetallic mineral product manufacturing"
	6           "Primary metals and fabricated metal products"
	7           "Machinery manufacturing"
	8           "Computer and electronic product manufacturing"
	9           "Electrical equipment, appliance manufacturing"
	10          "Transportation equipment manufacturing"
	11          "Wood products"
	12          "Furniture and fixtures manufacturing"
	13          "Miscellaneous and not specified manufacturing"
	14          "Food manufacturing"
	15          "Beverage and tobacco products"
	16          "Textile, apparel, and leather manufacturing"
	17          "Paper and printing"
	18          "Petroleum and coal products manufacturing"
	19          "Chemical manufacturing"
	20          "Plastics and rubber products"
	21          "Wholesale trade"
	22          "Retail trade"
	23          "Transportation and warehousing"
	24          "Utilities"
	25          "Publishing industries (except internet)"
	26          "Motion picture and sound recording industries"
	27          "Broadcasting (except internet)"
	28          "Internet publishing and broadcasting"
	29          "Telecommunications"
	30          "Internet service providers and data processing services"
	31          "Other information services"
	32          "Finance"
	33          "Insurance"
	34          "Real estate"
	35          "Rental and leasing services"
	36          "Professional and technical services"
	37          "Management of companies and enterprises"
	38          "Administrative and support services"
	39          "Waste management and remediation services"
	40          "Educational services"
	41          "Hospitals"
	42          "Health care services, except hospitals"
	43          "Social assistance"
	44          "Arts, entertainment, and recreation"
	45          "Accommodation"
	46          "Food services and drinking places"
	47          "Repair and maintenance"
	48          "Personal and laundry services"
	49          "Membership associations and organizations"
	50          "Private households"
	51          "Public administration"
	52          "Armed forces"
;
label values prdtocc1 prdtocca;
label define prdtocca
	1           "Management occupations"
	2           "Business and financial operations occupations"
	3           "Computer and mathematical science occupations"
	4           "Architecture and engineering occupations"
	5           "Life, physical, and social science occupations"
	6           "Community and social service occupations"
	7           "Legal occupations"
	8           "Education, training, and library occupations"
	9           "Arts, design, entertainment, sports, and media occupations"
	10          "Healthcare practitioner and technical occupations"
	11          "Healthcare support occupations"
	12          "Protective service occupations"
	13          "Food preparation and serving related occupations"
	14          "Building and grounds cleaning and maintenance occupations"
	15          "Personal care and service occupations"
	16          "Sales and related occupations"
	17          "Office and administrative support occupations"
	18          "Farming, fishing, and forestry occupations"
	19          "Construction and extraction occupations"
	20          "Installation, maintenance, and repair occupations"
	21          "Production occupations"
	22          "Transportation and material moving occupations"
	23          "Armed Forces"
;
label values prdtocc2 prdtoccb;
label define prdtoccb
	1           "Management occupations"
	2           "Business and financial operations occupations"
	3           "Computer and mathematical science occupations"
	4           "Architecture and engineering occupations"
	5           "Life, physical, and social science occupations"
	6           "Community and social service occupations"
	7           "Legal occupations"
	8           "Education, training, and library occupations"
	9           "Arts, design, entertainment, sports, and media occupations"
	10          "Healthcare practitioner and technical occupations"
	11          "Healthcare support occupations"
	12          "Protective service occupations"
	13          "Food preparation and serving related occupations"
	14          "Building and grounds cleaning and maintenance occupations"
	15          "Personal care and service occupations"
	16          "Sales and related occupations"
	17          "Office and administrative support occupations"
	18          "Farming, fishing, and forestry occupations"
	19          "Construction and extraction occupations"
	20          "Installation, maintenance, and repair occupations"
	21          "Production occupations"
	22          "Transportation and material moving occupations"
	23          "Armed Forces"
;
label values prmjind1 prmjinda;
label define prmjinda
	1           "Agriculture, forestry, fishing, and hunting"
	2           "Mining"
	3           "Construction"
	4           "Manufacturing"
	5           "Wholesale and retail trade"
	6           "Transportation and utilities"
	7           "Information"
	8           "Financial activities"
	9           "Professional and business services"
	10          "Educational and health services"
	11          "Leisure and hospitality"
	12          "Other services"
	13          "Public administration"
	14          "Armed Forces"
;
label values prmjind2 prmjindb;
label define prmjindb
	1           "Agriculture, forestry, fishing, and hunting"
	2           "Mining"
	3           "Construction"
	4           "Manufacturing"
	5           "Wholesale and retail trade"
	6           "Transportation and utilities"
	7           "Information"
	8           "Financial activities"
	9           "Professional and business services"
	10          "Educational and health services"
	11          "Leisure and hospitality"
	12          "Other services"
	13          "Public administration"
	14          "Armed Forces"
;
label values prmjocc1 prmjocca;
label define prmjocca
	1           "Management, business, and financial occupations"
	2           "Professional and related occupations"
	3           "Service occupations"
	4           "Sales and related occupations"
	5           "Office and administrative support occupations"
	6           "Farming, fishing, and forestry occupations"
	7           "Construction and extraction occupations"
	8           "Installation, maintenance, and repair occupations"
	9           "Production occupations"
	10          "Transportation and material moving occupations"
	11          "Armed Forces"
;
label values prmjocc2 prmjoccb;
label define prmjoccb
	1           "Management, business, and financial occupations"
	2           "Professional and related occupations"
	3           "Service occupations"
	4           "Sales and related occupations"
	5           "Office and administrative support occupations"
	6           "Farming, fishing, and forestry occupations"
	7           "Construction and extraction occupations"
	8           "Installation, maintenance, and repair occupations"
	9           "Production occupations"
	10          "Transportation and material moving occupations"
	11          "Armed Forces"
;
label values prmjocgr prmjocgr;
label define prmjocgr
	1           "Management, professional, and related occupations"
	2           "Service occupations"
	3           "Sales and office occupations"
	4           "Farming, fishing, and forestry occupations"
	5           "Construction, and maintenance occupations"
	6           "Production, transportation, and material moving occupations"
	7           "Armed Forces"
;
label values prsjmj   prsjmj;
label define prsjmj
	1           "SINGLE JOBHOLDER"
	2           "MULTIPLE JOBHOLDER"
;
label values prerelg  prerelg;
label define prerelg
	0           "NOT ELIGIBLE FOR EDIT"
	1           "ELIGIBLE FOR EDIT"
;
label values peernuot peernuot;
label define peernuot
	1           "YES"
	2           "NO"
;
label values peernper peernper;
label define peernper
	1           "HOURLY"
	2           "WEEKLY"
	3           "BI-WEEKLY"
	4           "TWICE MONTHLY"
	5           "MONTHLY"
	6           "ANNUALLY"
	7           "OTHER -- SPECIFY"
;
label values peernrt  peernrt;
label define peernrt
	1           "YES"
	2           "NO"
;
label values peernhry peernhry;
label define peernhry
	1           "HOURLY WORKER"
	2           "NONHOURLY WORKER"
;
label values pthr     pthr;
label define pthr
	0           "NOT TOPCODED"
	1           "TOPCODED"
;
label values ptot     ptot;
label define ptot
	0           "NOT TOPCODED"
	1           "TOPCODED"
;
label values peernlab peernlab;
label define peernlab
	1           "YES"
	2           "NO"
;
label values peerncov peerncov;
label define peerncov
	1           "YES"
	2           "NO"
;
label values penlfjh  penlfjh;
label define penlfjh
	1           "WITHIN THE LAST 12 MONTHS"
	2           "MORE THAN 12 MONTHS AGO"
	3           "NEVER WORKED"
;
label values penlfret penlfret;
label define penlfret
	1           "YES"
	2           "NO"
;
label values penlfact penlfact;
label define penlfact
	1           "DISABLED"
	2           "ILL"
	3           "IN SCHOOL"
	4           "TAKING CARE OF HOUSE OR FAMILY"
	5           "IN RETIREMENT"
	6           "SOMETHING ELSE/OTHER"
;
label values punlfck1 punlfcka;
label define punlfcka
	1           "IF AGERNG EQUALS 1-4 OR 9 THEN GOTO NLFACT"
	2           "ALL OTHERS GOT NLFRET"
;
label values punlfck2 punlfckb;
label define punlfckb
	1           "IF MISCK EQUALS 4 OR 8 THEN GOTO NLFJH"
	2           "ALL OTHERS GOTO LBFR-END"
;
label values peschenr peschenr;
label define peschenr
	1           "YES"
	2           "NO"
;
label values peschft  peschft;
label define peschft
	1           "FULL-TIME"
	2           "PART-TIME"
;
label values peschlvl peschlvl;
label define peschlvl
	1           "HIGH SCHOOL"
	2           "COLLEGE OR UNIVERSITY"
;
label values prnlfsch prnlfsch;
label define prnlfsch
	1           "IN SCHOOL"
	2           "NOT IN SCHOOL"
;
label values prchld   prchld;
label define prchld
	-1          "NIU (Not a parent)"
	0           "No own children under 18 years of age"
	1           "All own children 0- 2 years of age"
	2           "All own children 3- 5 years of age"
	3           "All own children 6-13 years of age"
	4           "All own children 14-17 years of age"
	5           "Own children 0- 2 and 3- 5 years of age (none 6-17)"
	6           "Own children 0- 2 and 6-13 years of age (none 3- 5 or 14-17)"
	7           "Own children 0- 2 and 14-17 years of age (none 3-13)"
	8           "Own children 3- 5 and 6-13 years of age (none 0- 2 or 14-17)"
	9           "Own children 3- 5 and 14-17 years of age (none 0- 2 or 6-13)"
	10          "Own children 6-13 and 14-17 years of age (none 0- 5)"
	11          "Own children 0- 2, 3- 5, and 6-13 years of age (none 14-17)"
	12          "Own children 0- 2, 3- 5, and 14-17 years of age (none 6-13)"
	13          "Own children 0- 2, 6-13, and 14-17 years of age (none 3- 5)"
	14          "Own children 3- 5, 6-13, and 14-17 years of age (none 0- 2)"
	15          "Own children from all age groups"
;
label values prnmchld prnmchld;
label define prnmchld
	-1          "NIU (Not a parent)"
	0           "VALUE - NO CHANGE"
	1           "BLANK - NO CHANGE"
	2           "DON'T KNOW - NO CHANGE"
	3           "REFUSED - NO CHANGE"
	10          "VALUE TO VALUE"
	11          "BLANK TO VALUE"
	12          "DON'T KNOW TO VALUE"
	13          "REFUSED TO VALUE"
	20          "VALUE TO LONGITUDINAL VALUE"
	21          "BLANK TO LONGITUDINAL VALUE"
	22          "DON'T KNOW TO LONGITUDINAL VALUE"
	23          "REFUSED TO LONGITUDINAL VALUE"
	30          "VALUE TO ALLOCATED VALUE LONG."
	31          "BLANK TO ALLOCATED VALUE LONG."
	32          "DON'T KNOW TO ALLOCATED VALUE LONG."
	33          "REFUSED TO ALLOCATED VALUE LONG."
	40          "VALUE TO ALLOCATED VALUE"
	41          "BLANK TO ALLOCATED VALUE"
	42          "DON'T KNOW TO ALLOCATED VALUE"
	43          "REFUSED TO ALLOCATED VALUE"
	50          "VALUE TO BLANK"
	52          "DON'T KNOW TO BLANK"
	53          "REFUSED TO BLANK"
;
label values pedipged pedipged;
label define pedipged
	1           "Graduation from high school"
	2           "GED or other equivalent"
;
label values pehgcomp pehgcomp;
label define pehgcomp
	1           "Less than 1st grade"
	2           "1st, 2nd, 3rd, or 4th grade"
	3           "5th or 6th grade"
	4           "7th or 8th grade"
	5           "9th grade"
	6           "10th grade"
	7           "11th grade"
	8           "12th grade (no diploma)"
;
label values pecyc    pecyc;
label define pecyc
	1           "Less than 1 year (includes 0 years completed)"
	2           "The first or Freshman year"
	3           "The second or Sophomore year"
	4           "The third or Junior year"
	5           "Four or more years"
;
label values primind1 priminda;
label define priminda
	1           "AGRICULTURE, FORESTRY, FISHING, and HUNTING"
	2           "MINING"
	3           "CONSTRUCTION"
	4           "MANUFACTURING - DURABLE GOODS"
	5           "MANUFACTURING - NON-DURABLE GOODS"
	6           "WHOLESALE TRADE"
	7           "RETAIL TRADE"
	8           "TRANSPORTATION AND WAREHOUSING"
	9           "UTILITIES"
	10          "INFORMATION"
	11          "FINANCE AND INSURANCE"
	12          "REAL ESTATE AND RENTAL AND LEASING"
	13          "PROFESSIONAL AND TECHNICAL SERVICES"
	14          "MANAGEMENT, ADMINISTRATIVE AND WASTE MANAGEMENT SERVICES"
	15          "EDUCATIONAL SERVICES"
	16          "HEALTH CARE AND SOCIAL SERVICES"
	17          "ARTS, ENTERTAINMENT, AND RECREATION"
	18          "ACCOMMODATION AND FOOD SERVICES"
	19          "PRIVATE HOUSEHOLDS"
	20          "OTHER SERVICES, EXCEPT PRIVATE HOUSEHOLDS"
	21          "PUBLIC ADMINISTRATION"
	22          "ARMED FORCES"
;
label values primind2 primindb;
label define primindb
	1           "AGRICULTURE, FORESTRY, FISHING, and HUNTING"
	2           "MINING"
	3           "CONSTRUCTION"
	4           "MANUFACTURING - DURABLE GOODS"
	5           "MANUFACTURING - NON-DURABLE GOODS"
	6           "WHOLESALE TRADE"
	7           "RETAIL TRADE"
	8           "TRANSPORTATION AND WAREHOUSING"
	9           "UTILITIES"
	10          "INFORMATION"
	11          "FINANCE AND INSURANCE"
	12          "REAL ESTATE AND RENTAL AND LEASING"
	13          "PROFESSIONAL AND TECHNICAL SERVICES"
	14          "MANAGEMENT, ADMINISTRATIVE AND WASTE MANAGEMENT SERVICES"
	15          "EDUCATIONAL SERVICES"
	16          "HEALTH CARE AND SOCIAL SERVICES"
	17          "ARTS, ENTERTAINMENT, AND RECREATION"
	18          "ACCOMMODATION AND FOOD SERVICES"
	19          "PRIVATE HOUSEHOLDS"
	20          "OTHER SERVICES, EXCEPT PRIVATE HOUSEHOLDS"
	21          "PUBLIC ADMINISTRATION"
	22          "ARMED FORCES"
;
label values peafwhn1 peafwhna;
label define peafwhna
	1           "SEPTEMBER 2001 OR LATER"
	2           "AUGUST 1990 TO AUGUST 2001"
	3           "MAY 1975 TO JULY 1990"
	4           "VIETNAM ERA (AUGUST 1964 TO APRIL 1975)"
	5           "FEBRUARY 1955 TO JULY 1964"
	6           "KOREAN WAR (JULY 1950 TO JANUARY 1955)"
	7           "JANUARY 1947 TO JUNE 1950"
	8           "WORLD WAR II (DECEMBER 1941 TO DECEMBER 1946)"
	9           "NOVEMBER 1941 OR EARLIER"
;
label values peafwhn2 peafwhnb;
label define peafwhnb
	1           "SEPTEMBER 2001 OR LATER"
	2           "AUGUST 1990 TO AUGUST 2001"
	3           "MAY 1975 TO JULY 1990"
	4           "VIETNAM ERA (AUGUST 1964 TO APRIL 1975)"
	5           "FEBRUARY 1955 TO JULY 1964"
	6           "KOREAN WAR (JULY 1950 TO JANUARY 1955)"
	7           "JANUARY 1947 TO JUNE 1950"
	8           "WORLD WAR II (DECEMBER 1941 TO DECEMBER 1946)"
	9           "NOVEMBER 1941 OR EARLIER"
;
label values peafwhn3 peafwhnc;
label define peafwhnc
	1           "SEPTEMBER 2001 OR LATER"
	2           "AUGUST 1990 TO AUGUST 2001"
	3           "MAY 1975 TO JULY 1990"
	4           "VIETNAM ERA (AUGUST 1964 TO APRIL 1975)"
	5           "FEBRUARY 1955 TO JULY 1964"
	6           "KOREAN WAR (JULY 1950 TO JANUARY 1955)"
	7           "JANUARY 1947 TO JUNE 1950"
	8           "WORLD WAR II (DECEMBER 1941 TO DECEMBER 1946)"
	9           "NOVEMBER 1941 OR EARLIER"
;
label values peafwhn4 peafwhnd;
label define peafwhnd
	1           "SEPTEMBER 2001 OR LATER"
	2           "AUGUST 1990 TO AUGUST 2001"
	3           "MAY 1975 TO JULY 1990"
	4           "VIETNAM ERA (AUGUST 1964 TO APRIL 1975)"
	5           "FEBRUARY 1955 TO JULY 1964"
	6           "KOREAN WAR (JULY 1950 TO JANUARY 1955)"
	7           "JANUARY 1947 TO JUNE 1950"
	8           "WORLD WAR II (DECEMBER 1941 TO DECEMBER 1946)"
	9           "NOVEMBER 1941 OR EARLIER"
;
label values pelndad  pelndad;
label define pelndad
	-1          "NO FATHER PRESENT"
;
label values pelnmom  pelnmom;
label define pelnmom
	-1          "NO MOTHER PRESENT"
;
label values pecohab  pecohab;
label define pecohab
	-1          "NO PARTNER PRESENT"
;
label values pedisear pedisear;
label define pedisear
	1           "Yes"
	2           "No"
;
label values pediseye pediseye;
label define pediseye
	1           "Yes"
	2           "No"
;
label values pedisrem pedisrem;
label define pedisrem
	1           "Yes"
	2           "No"
;
label values pedisphy pedisphy;
label define pedisphy
	1           "Yes"
	2           "No"
;
label values pedisdrs pedisdrs;
label define pedisdrs
	1           "Yes"
	2           "No"
;
label values pedisout pedisout;
label define pedisout
	1           "Yes"
	2           "No"
;
label values prdisflg prdisflg;
label define prdisflg
	1           "Yes"
	2           "No"
;
label values prdasian prdasian;
label define prdasian
	1           "Asian Indian"
	2           "Chinese"
	3           "Filipino"
	4           "Japanese"
	5           "Korean"
	6           "Vietnamese"
	7           "Other"
;
label values pepdemp1 pepdempa;
label define pepdempa
	1           "YES"
	2           "NO"
;
label values ptnmemp1 ptnmempa;
label define ptnmempa
	75          "75 or more employees"
;
label values pepdemp2 pepdempb;
label define pepdempb
	1           "YES"
	2           "NO"
;
label values ptnmemp2 ptnmempb;
label define ptnmempb
	10          "10 or more employees"
;
label values pecert1  pecert1l;
label define pecert1l
	1           "Yes"
	2           "No"
;
label values pecert2  pecert2l;
label define pecert2l
	1           "Yes"
	2           "No"
;
label values pecert3  pecert3l;
label define pecert3l
	1           "Yes"
	2           "No"
;
label values pesd1    pesd1l;
label define pesd1l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
;
label values pesd2    pesd2l;
label define pesd2l
	1           "Plant or company closed down or moved"
	2           "Insufficient work"
	3           "Position or shift abolished"
	4           "Seasonal job completed"
	5           "Self-operated business failed"
	6           "Some other reason"
	-2          "Don't Know"
	-3          "Refused"
;
label values pesd3    pesd3l;
label define pesd3l
	1           "2015"
	2           "2016"
	3           "2017"
	4           "Other"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesd4    pesd4l;
label define pesd4l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesd5    pesd5l;
label define pesd5l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values pesd6    pesd6l;
label define pesd6l
	1           "Less than 1 month"
	2           "1 to 2 months"
	3           "More than 2 months"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pescow1  pescow1l;
label define pescow1l
	1           "Federal government"
	2           "State government"
	3           "Local government"
	4           "Private for profit"
	5           "Private, nonprofit"
	6           "Self-employed, incorporated"
	7           "Self-employed, unincorporated"
	8           "Without pay"
	9           "Unknown"
	10          "Government, level unknown"
	11          "Self-employed, incorporation status unknown"
	-9          "No response"
;
label values pes1icd  pes1icd;
label define pes1icd
	-9          "No response"
;
label values prsdind  prsdind;
label define prsdind
	1           "Agriculture"
	2           "Forestry, logging, fishing, hunting, and trapping"
	3           "Mining"
	4           "Construction"
	5           "Nonmetallic mineral product manufacturing"
	6           "Primary metals and fabricated metal products"
	7           "Machinery manufacturing"
	8           "Computer and electronic product manufacturing"
	9           "Electrical equipment, appliance manufacturing"
	10          "Transportation equipment manufacturing"
	11          "Wood products"
	12          "Furniture and fixtures manufacturing"
	13          "Miscellaneous and not specified manufacturing"
	14          "Food manufacturing"
	15          "Beverage and tobacco products"
	16          "Textile, apparel, and leather manufacturing"
	17          "Paper and printing"
	18          "Petroleum and coal products manufacturing"
	19          "Chemical manufacturing"
	20          "Plastics and rubber products"
	21          "Wholesale trade"
	22          "Retail trade"
	23          "Transportation and warehousing"
	24          "Utilities"
	25          "Publishing industries (except internet)"
	26          "Motion picture and sound recording industries"
	27          "Broadcasting (except internet)"
	28          "Internet publishing and broadcasting"
	29          "Telecommunications"
	30          "Internet service providers and data processing"
	31          "Other information services"
	32          "Finance"
	33          "Insurance"
	34          "Real estate"
	35          "Rental and leasing services"
	36          "Professional and technical services"
	37          "Management of companies and enterprises"
	38          "Administrative and support services"
	39          "Waste management and remediation services"
	40          "Educational services"
	41          "Hospitals"
	42          "Health care services, except hospitals"
	43          "Social assistance"
	44          "Arts, entertainment, and recreation"
	45          "Accommodation"
	46          "Food services and drinking places"
	47          "Repair and maintenance"
	48          "Personal and laundry services"
	49          "Membership associations and organizations"
	50          "Private households"
	51          "Public administration"
	52          "Armed forces"
	-9          "No response"
;
label values pes1ocd  pes1ocd;
label define pes1ocd
	-9          "No response"
;
label values prsdocc  prsdocc;
label define prsdocc
	1           "Management occupations"
	2           "Business and financial operations occupations"
	3           "Computer and mathematical science occupations"
	4           "Architecture and engineering occupations"
	5           "Life, physical, and social science occupations"
	6           "Community and social service occupations"
	7           "Legal occupations"
	8           "Education, training, and library occupations"
	9           "Arts, design, entertainment, sports, and media occupations"
	10          "Healthcare practitioner and technical occupatio"
	11          "Healthcare support occupations"
	12          "Protective service occupations"
	13          "Food preparation and serving related occupation"
	14          "Building and grounds cleaning and maintenance occupations"
	15          "Personal care and service occupations"
	16          "Sales and related occupations"
	17          "Office and administrative support occupations"
	18          "Farming, fishing, and forestry occupations"
	19          "Construction and extraction occupations"
	20          "Installation, maintenance, and repair occupatio"
	21          "Production occupations"
	22          "Transportation and material moving occupations"
	23          "Armed Forces"
	-9          "No response"
;
label values pesd16   pesd16l;
label define pesd16l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesd17   pesd17l;
label define pesd17l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values ptsd18a  ptsd18a;
label define ptsd18a
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesd18b  pesd18b;
label define pesd18b
	1           "Days"
	2           "Weeks"
	3           "Months"
	4           "Years"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values pesd19   pesd19l;
label define pesd19l
	1           "Yes"
	2           "No"
	-4          "Hours varied"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesle1o  pesle1o;
label define pesle1o
	1           "Hourly"
	2           "Weekly"
	3           "Bi-weekly"
	4           "Twice monthly"
	5           "Monthly"
	6           "Annually"
	7           "Other"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesle2   pesle2l;
label define pesle2l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesenh1o pesenh1o;
label define pesenh1o
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values ptsenh1o ptsenh1o;
label define ptsenh1o
	-1          "NIU"
	0           "No topcode"
	1           "Topcoded value"
;
label values ptsle4o  ptsle4o;
label define ptsle4o
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pusle5   pusle5l;
label define pusle5l
	1           "Per hour"
	2           "Per day"
	3           "Per week"
	4           "Per month"
	5           "Per year"
	6           "Other"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values putsle6  putsle6l;
label define putsle6l
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pusle6d  pusle6d;
label define pusle6d
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values ptsern   ptsern;
label define ptsern
	-1          "NIU"
	0           "No topcode"
	1           "Topcoded value"
;
label values ptsern2  ptsern2l;
label define ptsern2l
	-1          "NIU"
	0           "No topcode"
	1           "Topcoded value"
;
label values pesle22  pesle22l;
label define pesle22l
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesd20   pesd20l;
label define pesd20l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesd21   pesd21l;
label define pesd21l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesd22   pesd22l;
label define pesd22l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesd23   pesd23l;
label define pesd23l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesd24   pesd24l;
label define pesd24l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values ptsd25   ptsd25l;
label define ptsd25l
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values pesd26   pesd26l;
label define pesd26l
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values pesd27   pesd27l;
label define pesd27l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesce2o  pesce2o;
label define pesce2o
	1           "Hourly"
	2           "Weekly"
	3           "Bi-weekly"
	4           "Twice monthly"
	5           "Monthly"
	6           "Annually"
	7           "Other-specify"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pesce3   pesce3l;
label define pesce3l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values peseh1oa peseh1oa;
label define peseh1oa
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values ptseh1oa ptseh1oa;
label define ptseh1oa
	-1          "NIU"
	0           "No topcode"
	1           "Topcoded value"
;
label values putsce5  putsce5l;
label define putsce5l
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values ptsce5o  ptsce5o;
label define ptsce5o
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pusce6   pusce6l;
label define pusce6l
	1           "Per hour"
	2           "Per day"
	3           "Per week"
	4           "Per month"
	5           "Per year"
	6           "Other"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values putsce7  putsce7l;
label define putsce7l
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values pusce8   pusce8l;
label define pusce8l
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values ptsern1  ptsern1l;
label define ptsern1l
	-1          "NIU"
	0           "No topcode"
	1           "Topcoded value"
;
label values ptsern2a ptsern2a;
label define ptsern2a
	-1          "NIU"
	0           "No topcode"
	1           "Topcoded value"
;
label values pesce25  pesce25l;
label define pesce25l
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values prslwkly prslwkly;
label define prslwkly
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values ptslwkly ptslwkly;
label define ptslwkly
	-1          "NIU"
	0           "No topcode"
	1           "Topcoded value"
;
label values prscwkly prscwkly;
label define prscwkly
	-1          "Month-in-sample 4 and 8 cases not eligible"
;
label values ptscwkly ptscwkly;
label define ptscwkly
	-1          "NIU"
	0           "No topcode"
	1           "Topcoded value"
;
label values peshry   peshry;
label define peshry
	1           "Hourly worker"
	2           "Nonhourly worker"
;
label values prshr    prshr;
label define prshr
	0           "Minimum Value"
	9999        "Maximum Value"
;
label values prsupern prsupern;
label define prsupern
	1           "Eligible"
;
label values ptst1a   ptst1a;
label define ptst1a
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values pest1b   pest1b;
label define pest1b
	1           "Days"
	2           "Weeks"
	3           "Months"
	4           "Years"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values pest3    pest3l;
label define pest3l
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values pest7    pest7l;
label define pest7l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values pest8    pest8l;
label define pest8l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values pescow2  pescow2l;
label define pescow2l
	1           "Federal government"
	2           "State government"
	3           "Local government"
	4           "Private for profit"
	5           "Private, nonprofit"
	6           "Self-employed, incorporated"
	7           "Self-employed, unincorporated"
	8           "Without pay"
	9           "Unknown"
	10          "Government, level unknown"
	11          "Self-employed, incorporation status unknown"
	-9          "No response"
;
label values pes2icd  pes2icd;
label define pes2icd
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values prsd2ind prsd2ind;
label define prsd2ind
	1           "Agriculture"
	2           "Forestry, logging, fishing, hunting, and trapping"
	3           "Mining"
	4           "Construction"
	5           "Nonmetallic mineral product manufacturing"
	6           "Primary metals and fabricated metal products"
	7           "Machinery manufacturing"
	8           "Computer and electronic product manufacturing"
	9           "Electrical equipment, appliance manufacturin"
	10          "Transportation equipment manufacturing"
	11          "Wood products"
	12          "Furniture and fixtures manufacturing"
	13          "Miscellaneous and not specified manufacturing"
	14          "Food manufacturing"
	15          "Beverage and tobacco products"
	16          "Textile, apparel, and leather manufacturing"
	17          "Paper and printing"
	18          "Petroleum and coal products manufacturing"
	19          "Chemical manufacturing"
	20          "Plastics and rubber products"
	21          "Wholesale trade"
	22          "Retail trade"
	23          "Transportation and warehousing"
	24          "Utilities"
	25          "Publishing industries (except internet)"
	26          "Motion picture and sound recording industries"
	27          "Broadcasting (except internet)"
	28          "Internet publishing and broadcasting"
	29          "Telecommunications"
	30          "Internet service providers and data processing services"
	31          "Other information services"
	32          "Finance"
	33          "Insurance"
	34          "Real estate"
	35          "Rental and leasing services"
	36          "Professional and technical services"
	37          "Management of companies and enterprises"
	38          "Administrative and support services"
	39          "Waste management and remediation services"
	40          "Educational services"
	41          "Hospitals"
	42          "Health care services, except hospitals"
	43          "Social assistance"
	44          "Arts, entertainment, and recreation"
	45          "Accommodation"
	46          "Food services and drinking places"
	47          "Repair and maintenance"
	48          "Personal and laundry services"
	49          "Membership associations and organizations"
	50          "Private households"
	51          "Public administration"
	52          "Armed forces"
	-9          "No response"
;
label values pes2ocd  pes2ocd;
label define pes2ocd
	-2          "Don't Know"
	-3          "Refused"
	-9          "No response"
;
label values prsd2occ prsd2occ;
label define prsd2occ
	1           "Management occupations"
	2           "Business and financial operations occupations"
	3           "Computer and mathematical science occupations"
	4           "Architecture and engineering occupations"
	5           "Life, physical, and social science occupations"
	6           "Community and social service occupations"
	7           "Legal occupations"
	8           "Education, training, and library occupations"
	9           "Arts, design, entertainment, sports, and media occupations"
	10          "Healthcare practitioner and technical occupations"
	11          "Healthcare support occupations"
	12          "Protective service occupations"
	13          "Food preparation and serving related occupations"
	14          "Building and grounds cleaning and maintenance occupations"
	15          "Personal care and service occupations"
	16          "Sales and related occupations"
	17          "Office and administrative support occupations"
	18          "Farming, fishing, and forestry occupations"
	19          "Construction and extraction occupations"
	20          "Installation, maintenance, and repair occupations"
	21          "Production occupations"
	22          "Transportation and material moving occupations"
	23          "Armed Forces"
	-9          "No response"
;
label values pest20   pest20l;
label define pest20l
	1           "Yes"
	2           "No"
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values pusd7    pusd7l;
label define pusd7l
	1           "Government"
	2           "Private-for-profit company"
	3           "Non-profit organization (incl. tax exempt"
	4           "Self-employed"
	5           "Working in the family business"
	-2          "Don't Know"
	-3          "Refused"
;
label values pest25   pest25l;
label define pest25l
	1           "Government"
	2           "Private-for-profit company"
	3           "Non-profit organization (incl. tax exempt and charitable"
	4           "Self-employed"
	5           "Working in the family business"
	-2          "Don't Know"
	-3          "Refused"
;
label values pest26   pest26l;
label define pest26l
	1           "Federal"
	2           "State"
	3           "Local"
	-1          "Out of universe"
	-2          "Don't Know"
	-3          "Refused"
;
label values pest27   pest27l;
label define pest27l
	1           "Yes"
	2           "No"
	-1          "Out of universe"
	-2          "Don't Know"
	-3          "Refused"
;
label values pest31   pest31l;
label define pest31l
	1           "Manufacturing"
	2           "Retail trade"
	3           "Wholesale trade"
	4           "Something else"
	-1          "Out of universe"
	-2          "Don't Know"
	-3          "Refused"
;
label values prsupsat prsupsat;
label define prsupsat
	1           "Not Eligible for Displaced Worker Items -"
	2           "Interview - Interviews had to meet the following"
	3           "Noninterview - Cases that met the eligibility"
;
label values prtensat prtensat;
label define prtensat
	1           "Not Eligible for Job Tenure and Occupational"
	2           "Interview - Interviews had to meet the"
	3           "Noninterview - Cases that met the eligibility"
;
label values ptst1tn  ptst1tn;
label define ptst1tn
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;
label values ptsd18tn ptsd18tn;
label define ptsd18tn
	-2          "Don't Know"
	-3          "Refused"
	-9          "No Response"
;

#delimit cr
compress
saveold "`dta_name'" , version(11) replace

/*
Copyright 2018 shared by the National Bureau of Economic Research and Jean Roth

National Bureau of Economic Research.
1050 Massachusetts Avenue
Cambridge, MA 02138
jroth@nber.org

This program and all programs referenced in it are free software. You
can redistribute the program or modify it under the terms of the GNU
General Public License as published by the Free Software Foundation;
either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
USA.
*/
