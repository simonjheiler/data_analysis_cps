local in_file `1'
local out_file `2'
local data_dict `3'
local variables `4'

/*------------------------------------------------
  developed by Jean Roth
  edited by Simon Heiler Thu Jul 02 18:00:00 CEST 2020
  NOTE:  This program is distributed under the GNU GPL.
  See end of this file and http://www.gnu.org/licenses/ for details.
----------------------------------------------- */

/* The following line should contain the complete path and name of the raw data file */

local dat_name `in_file'

/* The following line should contain the path to the data dictionary file */

local dct_name `data_dict'

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

  Variable names in Stata are case-sensitive

 -----------------------------------------------*/

*The replace statements append household
*and family variables to their respective
*person records.

replace  hhseqnum =  hhseqnum[_n-1]  if  hrecord>1
replace     hhpos =     hhpos[_n-1]  if  hrecord>1
replace   numpers =   numpers[_n-1]  if  hrecord>1
replace    numfam =    numfam[_n-1]  if  hrecord>1
replace    hhtype =    hhtype[_n-1]  if  hrecord>1
replace  ppindind =  ppindind[_n-1]  if  hrecord>1
replace   h_hhnum =   h_hhnum[_n-1]  if  hrecord>1
replace       mis =       mis[_n-1]  if  hrecord>1
replace   hhidnum =   hhidnum[_n-1]  if  hrecord>1
replace  bitm14rc =  bitm14rc[_n-1]  if  hrecord>1
replace  bitm15rc =  bitm15rc[_n-1]  if  hrecord>1
replace    bniwgt =    bniwgt[_n-1]  if  hrecord>1
replace     numhu =     numhu[_n-1]  if  hrecord>1
replace  pmsarank =  pmsarank[_n-1]  if  hrecord>1
replace    region =    region[_n-1]  if  hrecord>1
replace  division =  division[_n-1]  if  hrecord>1
replace  kststate =  kststate[_n-1]  if  hrecord>1
replace  mststran =  mststran[_n-1]  if  hrecord>1
replace    mprank =    mprank[_n-1]  if  hrecord>1
replace  smsafips =  smsafips[_n-1]  if  hrecord>1
replace  mstsmsar =  mstsmsar[_n-1]  if  hrecord>1
replace   cccsmsa =   cccsmsa[_n-1]  if  hrecord>1
replace  smsasizr =  smsasizr[_n-1]  if  hrecord>1
replace   msarank =   msarank[_n-1]  if  hrecord>1
replace   msasize =   msasize[_n-1]  if  hrecord>1
replace  landusag =  landusag[_n-1]  if  hrecord>1
replace    aitem9 =    aitem9[_n-1]  if  hrecord>1
replace     item4 =     item4[_n-1]  if  hrecord>1
replace    tenure =    tenure[_n-1]  if  hrecord>1
replace    public =    public[_n-1]  if  hrecord>1
replace  lowerren =  lowerren[_n-1]  if  hrecord>1
replace   tenallo =   tenallo[_n-1]  if  hrecord>1
replace    cccode =    cccode[_n-1]  if  hrecord>1
replace  hhstatus =  hhstatus[_n-1]  if  hrecord>1
replace   hhund18 =   hhund18[_n-1]  if  hrecord>1
replace  hhinctot =  hhinctot[_n-1]  if  hrecord>1
replace  hhrecrel =  hhrecrel[_n-1]  if  hrecord>1
replace  hhnumnrl =  hhnumnrl[_n-1]  if  hrecord>1
replace  hhnumcpl =  hhnumcpl[_n-1]  if  hrecord>1
replace  hht0p5pc =  hht0p5pc[_n-1]  if  hrecord>1
replace  hhpctcut =  hhpctcut[_n-1]  if  hrecord>1
replace   hnumhot =   hnumhot[_n-1]  if  hrecord>1
replace  hfreelun =  hfreelun[_n-1]  if  hrecord>1
replace  hnumfree =  hnumfree[_n-1]  if  hrecord>1
replace   hfoodsp =   hfoodsp[_n-1]  if  hrecord>1
replace    hnumfs =    hnumfs[_n-1]  if  hrecord>1
replace    hnummo =    hnummo[_n-1]  if  hrecord>1
replace hvalllefs = hvalllefs[_n-1]  if  hrecord>1
replace  hfsalflg =  hfsalflg[_n-1]  if  hrecord>1
replace  henrgyas =  henrgyas[_n-1]  if  hrecord>1
replace  henrgyhe =  henrgyhe[_n-1]  if  hrecord>1
replace  hehrgyfl =  hehrgyfl[_n-1]  if  hrecord>1
replace   ph0hehh =   ph0hehh[_n-1]  if  hrecord>1
replace  phoheavl =  phoheavl[_n-1]  if  hrecord>1
replace  hflagast =  hflagast[_n-1]  if  hrecord>1
replace   hflaghe =   hflaghe[_n-1]  if  hrecord>1
replace   hflagfl =   hflagfl[_n-1]  if  hrecord>1
replace  hhsupwgt =  hhsupwgt[_n-1]  if  hrecord>1
replace  hhrectyp =  hhrectyp[_n-1]  if  hrecord>1
replace  ffseqnum =  ffseqnum[_n-1]  if  precord==3
replace     ffpos =     ffpos[_n-1]  if  precord==3
replace     fkind =     fkind[_n-1]  if  precord==3
replace     ftype =     ftype[_n-1]  if  precord==3
replace  fpersons =  fpersons[_n-1]  if  precord==3
replace  fhouhind =  fhouhind[_n-1]  if  precord==3
replace  fspousin =  fspousin[_n-1]  if  precord==3
replace  flastind =  flastind[_n-1]  if  precord==3
replace  fspanhea =  fspanhea[_n-1]  if  precord==3
replace    fincws =    fincws[_n-1]  if  precord==3
replace    fincse =    fincse[_n-1]  if  precord==3
replace    fincfr =    fincfr[_n-1]  if  precord==3
replace    fincus =    fincus[_n-1]  if  precord==3
replace    fincsp =    fincsp[_n-1]  if  precord==3
replace    fincpa =    fincpa[_n-1]  if  precord==3
replace   fincint =   fincint[_n-1]  if  precord==3
replace   fincdiv =   fincdiv[_n-1]  if  precord==3
replace    fincvp =    fincvp[_n-1]  if  precord==3
replace   fincret =   fincret[_n-1]  if  precord==3
replace    finccs =    finccs[_n-1]  if  precord==3
replace   finctot =   finctot[_n-1]  if  precord==3
replace  fincearn =  fincearn[_n-1]  if  precord==3
replace   fincoth =   fincoth[_n-1]  if  precord==3
replace  flfincws =  flfincws[_n-1]  if  precord==3
replace  flfincse =  flfincse[_n-1]  if  precord==3
replace  flfincfr =  flfincfr[_n-1]  if  precord==3
replace  flfincus =  flfincus[_n-1]  if  precord==3
replace  flfincsp =  flfincsp[_n-1]  if  precord==3
replace  flfincpa =  flfincpa[_n-1]  if  precord==3
replace  flfincin =  flfincin[_n-1]  if  precord==3
replace  flfincdi =  flfincdi[_n-1]  if  precord==3
replace  flfincvp =  flfincvp[_n-1]  if  precord==3
replace  flfincre =  flfincre[_n-1]  if  precord==3
replace  flfinccs =  flfinccs[_n-1]  if  precord==3
replace  flfincto =  flfincto[_n-1]  if  precord==3
replace  flfincea =  flfincea[_n-1]  if  precord==3
replace  flfincot =  flfincot[_n-1]  if  precord==3
replace  frecode1 =  frecode1[_n-1]  if  precord==3
replace  frecod98 =  frecod98[_n-1]  if  precord==3
replace  frecode5 =  frecode5[_n-1]  if  precord==3
replace  frecode6 =  frecode6[_n-1]  if  precord==3
replace  frecode7 =  frecode7[_n-1]  if  precord==3
replace     frec8 =     frec8[_n-1]  if  precord==3
replace     frec9 =     frec9[_n-1]  if  precord==3
replace    frec10 =    frec10[_n-1]  if  precord==3
replace    frec11 =    frec11[_n-1]  if  precord==3
replace    frec12 =    frec12[_n-1]  if  precord==3
replace    frec13 =    frec13[_n-1]  if  precord==3
replace    frec14 =    frec14[_n-1]  if  precord==3
replace    frec15 =    frec15[_n-1]  if  precord==3
replace    frec16 =    frec16[_n-1]  if  precord==3
replace    frec17 =    frec17[_n-1]  if  precord==3
replace    frec19 =    frec19[_n-1]  if  precord==3
replace    frec21 =    frec21[_n-1]  if  precord==3
replace   fundr18 =   fundr18[_n-1]  if  precord==3
replace  rec5to17 =  rec5to17[_n-1]  if  precord==3
replace    frec25 =    frec25[_n-1]  if  precord==3
replace    frec26 =    frec26[_n-1]  if  precord==3
replace    frec27 =    frec27[_n-1]  if  precord==3
replace   frec31a =   frec31a[_n-1]  if  precord==3
replace   frec31b =   frec31b[_n-1]  if  precord==3
replace   frec31c =   frec31c[_n-1]  if  precord==3
replace   frec31d =   frec31d[_n-1]  if  precord==3
replace   frec31e =   frec31e[_n-1]  if  precord==3
replace   frec31f =   frec31f[_n-1]  if  precord==3
replace   frec31g =   frec31g[_n-1]  if  precord==3
replace   frec31h =   frec31h[_n-1]  if  precord==3
replace  ftop5pct =  ftop5pct[_n-1]  if  precord==3
replace   fpctcut =   fpctcut[_n-1]  if  precord==3
replace   flowinc =   flowinc[_n-1]  if  precord==3
replace    rpovll =    rpovll[_n-1]  if  precord==3
replace   rfincm2 =   rfincm2[_n-1]  if  precord==3
replace   rfsinc2 =   rfsinc2[_n-1]  if  precord==3
replace   fsupwgt =   fsupwgt[_n-1]  if  precord==3
replace  fwifeinx =  fwifeinx[_n-1]  if  precord==3
replace  fhusbinx =  fhusbinx[_n-1]  if  precord==3

replace hrecord = 1
keep if precord==3

** These note statements incorporate variable universes into the Stata data file.
note: by Jean Roth, jroth@nber.org Tue Aug 19 14:46:51 EDT 2014
note hhpos: U ALL HOUsEHOLDs
note numpers: U ALL HOUSEHOLDS
note ppindind: U ALL HOUSEHOLDS
note h_hhnum: U ALL HOUSEHOLDS
note mis: U ALL HOUSEHOLDS
note hhidnum: U ALL HOUSEHOLDS
note bitm14rc: U ALL HOUSEHOLDS
note bitm15rc: U TYPE A N0NINTERVIEWED HOUSEHOLDS
note bniwgt: U TYPE B-C N0NINTERVIEWED HOUSEHOLDS
note numhu: U ALL N0NINTERVIEWED HOUSEHOLDS
note pmsarank: U ALL HOUSEHOLDS
note region: U SEE LIST 2 OF APPENDIX E
note division: U ALL HOUSEHOLDS
note kststate: U ALL HOUSEHOLDS
note mststran: U ALL HOUSEHOLDS
note mprank: U ALL HOUSEHOLDS
note mstsmsar: U ALL HOUSEHOLDS
note cccsmsa: U ALL HOUSEHOLDS
note smsasizr: U ALL HOUSEHOLDS
note msarank: U ALL HOUSEHOLDS
note msasize: U ALL HOUSEHOLDS
note landusag: U ALL HOUSEHOLDS
note aitem9: U ALL HOUSEHOLDS
note item4: U ALL HOUSEHOLDS
note tenure: U ALL HOUSEHOLDS
note public: U ALL HOUSEHOLDS
note lowerren: U ALL HOUSEHOLDS NOT OWNED OR BEING
note tenallo: U ALL HOUSEHOLDS NOT OWNED OR BEING
note cccode: U ALL HOUSEHOLDS
note hhstatus: U ALL HOUSEHOLDS
note hhund18: U ALL HOUSEHOLDS
note hhinctot: U ALL HOUSEHOLDS
note hhrecrel: U ALL HOUSEHOLDS
note hhnumnrl: U ALL HOUSEHOLDS
note hhnumcpl: U ALL HOUSEHOLDS
note hht0p5pc: U ALL HOUSEHOLDS
note hhpctcut: U ALL HOUSEHOLDS
note hnumhot: U ALL HOUSEHOLDS
note hfreelun: U HOUSEHOLDS IN WHICH CHILDREN RECEIVE
note hnumfree: U HOUSEHOLDS WITH CHILDREN 5-18 WHO
note hfoodsp: U HOUSEHOLDS IN WHICH CHILDREN RECEIVE
note hnumfs: U ALL HOUSEHOLDS WITH INCOME LESS THAN $30,000
note hnummo: U HOUSEHOLDS WHICH RECEIVED FOOD STAMPS
note hvalllefs: U HOUSEHOLDS WHICH RECEIVED FOOD STAMPS
note hfsalflg: U HOUSEHOLDS WHICH RECEIVED FOOD STAMPS
note henrgyas: U ALL HOUSEHOLDS
note henrgyhe: U ALL HOUSEHOLDS WITH INCOME LESS THAN
note hehrgyfl: U HOUSEHOLDS PARTICIPATING IN THE
note ph0hehh: U ALL HOUSEHOLDS WITH INCOME LESS THAN
note phoheavl: U ALL HOUSEHOLDS
note hflagast: U HH IN WHICH THERE IS HO TELEPHONE
note ditem21c: U UNIVERSE IS ESR=2
note ditm22a1: U UNIVERSE IS ESR=2
note ditm22a2: U UNIVERSE IS ESR=3
note ditm22a4: U UNIVERSE IS ESR=3
note ditm22a5: U UNIVERSE IS ESR=3
note ditm22a6: U UNIVERSE IS ESR=3
note ditm22a7: U UNIVERSE IS ESR=4 TO 7
note ditm24d2: U UNIVERSE IS DEFINED ON CIVILIAN AGE
note ditm24d3: U UNIVERSE IS DEFINED ON CIVILIAN
note ditm24d4: U UNIVERSE IS DEFINED ON CIVILIAN
note ditm24d5: U UNIVERSE IS DEFINED ON CIVILIAN
note ditm24d6: U UNIVERSE IS DEFINED ON CIVILIAN
note ditm24d7: U UNIVERSE IS DEFINED ON CIVILIAN
note ditm24d9: U UNIVERSE IS DEFINED ON CIVILIAN
note oit24d10: U AGE 14*, MONTH IN SAMPLE 4 OR 8, ESR
note dit24d11: U UNIVERSE IS DEFINED ON CIVILIAN
note ditem22b: U UNIVERSE IS DEFINED ON CIVILIAN AGE
note ditem22c: U UNIVERSE IS ESR=3 ITEM 21A NOT
note ditem22d: U UNIVERSE IS ESR=3
note ditm22e1: U UNIVERSE IS ESR=3
note ditm22e2: U UNIVERSE IS ESR=3
note ditem22f: U UNIVERSE IS U1 OR U2 U1 IS ESR=3 AND ITEM22E1=1 U2 IS ESR=4 TO 7
note ditem24a: U UNIVERSE IS ESR=1,2, OR 3 OR ESR=4-7
note ditem24b: U UNIVERSE IS ESR=4 TO 7 AND MONTH IN SAMPLE = 4 OR 8
note ditem24c: U UNIVERSE IS ESR=4 TO 7 AND MONTH IN
note ditem24e: U UNIVERSE IS ESR=4 TO 7 AND MONTH IN SAMPLE IS 4 OR 8
note baalllf: U UNIVERSE IS ESR=4 TO 7 AND
*Everything below this point, aside from the final save, are value labels


/*saveold `dta_name' , replace*/
outsheet `variables' using `out_file', comma replace
log close


/*
Copyright 2014 shared by the National Bureau of Economic Research and Jean Roth

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
