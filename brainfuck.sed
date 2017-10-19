:install

# input whole program
$! {
  N
  b install
}

# this fucking regex removes other characters
s/[^]>+<.,[-]//g
s/.*/@&/

x

# create memory
s/.*/@\
/

x

# clear branch flag
t loop
: loop

p
x
p
x

# end of execution. print the output stream buffer
/@$/ {
  b output
}

/@+/ {
  i\
### INCR

  x
  # increment!
  s/@1*/&1/

  # modulo 256. note that repetition count ge than 256 is illegal in basic regex
  s/@1\{128\}1\{128\}/@/

  x
  b next
}

/@-/ {
  i\
### DECR

  x
  # decrement if possible
  s/@1\(1*\)/@\1/

  x
  b next
}

/@>/ {
  i\
### NEXT

  x

  # append '|' if neccesary
  /@1*\n/ {
    s/\n/|\
/
  }

  # shift to next cell (ex. @1111|11 -> |1111@11)
  s/@\(1*\)|/|\1@/

  x
  b next
}

/@</ {
  i\
### PREV

  x

  s/|\(1*\)@/@\1|/

  x
  b next
}

/@\./ {
  i\
### PUTC

  x

  s/^[|1]*@\(1*\)[|1]*\n[|1]*$/&|\1/

  x
  b next
}

/@\[/ {
  i\
### OPEN

  x

  # value isn't zero
  /@1/ {
    x
    b next
  }

  x
  
  # 'o' is bracket open counter 
  s/^/o/

: skipopens
  /^o/ {
    s/@\(.\)/\1@/

    /@\[/ {
      s/^/o/
    }
    /@\]/ {
      s/^o//
    }

    b skipopens
  }

  b next
}

/@\]/ {
 i\
### CLOSE

  # 'c' is bracket close counter
  s/^/c/

: skipcloses
  /^c/ {
    s/\(.\)@/@\1/

    /@\[/ {
      s/^c//
    }
    /@\]/ {
      s/^/c/
    }

    b skipcloses
  }

  s/\(.\)@/@\1/

  b next
}

: next

s/@\(.\)/\1@/

b loop


: output


# delete memory
x
s/.*\n//

#
s/1\{16\}/a/g
s/|\(a*\)\(1*\)/|\1|\2/g
y/1/a/

s/|a\{15\}/P/g
s/|a\{14\}/O/g
s/|a\{13\}/N/g
s/|a\{12\}/M/g
s/|a\{11\}/L/g
s/|a\{10\}/K/g
s/|a\{9\}/J/g
s/|a\{8\}/I/g
s/|a\{7\}/H/g
s/|a\{6\}/G/g
s/|aaaaa/F/g
s/|aaaa/E/g
s/|aaa/D/g
s/|aa/C/g
s/|a/B/g
s/|/A/g

s/\(..\)/|\1/g


s/|AB//g
s/|AC//g
s/|AD//g
s/|AE//g
s/|AF//g
s/|AG//g
s/|AH//g
s/|AI//g
s/|AJ/	/g
s/|AK/\
/g
s/|AL//g
s/|AM//g
s/|AN//g
s/|AO//g
s/|AP//g
s/|BA//g
s/|BB//g
s/|BC//g
s/|BD//g
s/|BE//g
s/|BF//g
s/|BG//g
s/|BH//g
s/|BI//g
s/|BJ//g
s/|BK//g
s/|BL//g
s/|BM//g
s/|BN//g
s/|BO//g
s/|BP//g
s/|CA/ /g
s/|CB/!/g
s/|CC/"/g
s/|CD/#/g
s/|CE/$/g
s/|CF/%/g
s/|CG/\&/g
s/|CH/'/g
s/|CI/(/g
s/|CJ/)/g
s/|CK/*/g
s/|CL/+/g
s/|CM/,/g
s/|CN/-/g
s/|CO/./g
s/|CP/\//g
s/|DA/0/g
s/|DB/1/g
s/|DC/2/g
s/|DD/3/g
s/|DE/4/g
s/|DF/5/g
s/|DG/6/g
s/|DH/7/g
s/|DI/8/g
s/|DJ/9/g
s/|DK/:/g
s/|DL/;/g
s/|DM/</g
s/|DN/=/g
s/|DO/>/g
s/|DP/?/g
s/|EA/@/g
s/|EB/A/g
s/|EC/B/g
s/|ED/C/g
s/|EE/D/g
s/|EF/E/g
s/|EG/F/g
s/|EH/G/g
s/|EI/H/g
s/|EJ/I/g
s/|EK/J/g
s/|EL/K/g
s/|EM/L/g
s/|EN/M/g
s/|EO/N/g
s/|EP/O/g
s/|FA/P/g
s/|FB/Q/g
s/|FC/R/g
s/|FD/S/g
s/|FE/T/g
s/|FF/U/g
s/|FG/V/g
s/|FH/W/g
s/|FI/X/g
s/|FJ/Y/g
s/|FK/Z/g
s/|FL/[/g
s/|FM/\\/g
s/|FN/]/g
s/|FO/^/g
s/|FP/_/g
s/|GA/`/g
s/|GB/a/g
s/|GC/b/g
s/|GD/c/g
s/|GE/d/g
s/|GF/e/g
s/|GG/f/g
s/|GH/g/g
s/|GI/h/g
s/|GJ/i/g
s/|GK/j/g
s/|GL/k/g
s/|GM/l/g
s/|GN/m/g
s/|GO/n/g
s/|GP/o/g
s/|HA/p/g
s/|HB/q/g
s/|HC/r/g
s/|HD/s/g
s/|HE/t/g
s/|HF/u/g
s/|HG/v/g
s/|HH/w/g
s/|HI/x/g
s/|HJ/y/g
s/|HK/z/g
s/|HL/{/g
s/|HN/}/g
s/|HO/~/g
s/|HP//g
s/|IA/Ä/g
s/|IB/Å/g
s/|IC/Ç/g
s/|ID/É/g
s/|IE/Ñ/g
s/|IF/Ö/g
s/|IG/Ü/g
s/|IH/á/g
s/|II/à/g
s/|IJ/â/g
s/|IK/ä/g
s/|IL/ã/g
s/|IM/å/g
s/|IN/ç/g
s/|IO/é/g
s/|IP/è/g
s/|JA/ê/g
s/|JB/ë/g
s/|JC/í/g
s/|JD/ì/g
s/|JE/î/g
s/|JF/ï/g
s/|JG/ñ/g
s/|JH/ó/g
s/|JI/ò/g
s/|JJ/ô/g
s/|JK/ö/g
s/|JL/õ/g
s/|JM/ú/g
s/|JN/ù/g
s/|JO/û/g
s/|JP/ü/g
s/|KA/†/g
s/|KB/°/g
s/|KC/¢/g
s/|KD/£/g
s/|KE/§/g
s/|KF/•/g
s/|KG/¶/g
s/|KH/ß/g
s/|KI/®/g
s/|KJ/©/g
s/|KK/™/g
s/|KL/´/g
s/|KM/¨/g
s/|KN/≠/g
s/|KO/Æ/g
s/|KP/Ø/g
s/|LA/∞/g
s/|LB/±/g
s/|LC/≤/g
s/|LD/≥/g
s/|LE/¥/g
s/|LF/µ/g
s/|LG/∂/g
s/|LH/∑/g
s/|LI/∏/g
s/|LJ/π/g
s/|LK/∫/g
s/|LL/ª/g
s/|LM/º/g
s/|LN/Ω/g
s/|LO/æ/g
s/|LP/ø/g
s/|MA/¿/g
s/|MB/¡/g
s/|MC/¬/g
s/|MD/√/g
s/|ME/ƒ/g
s/|MF/≈/g
s/|MG/∆/g
s/|MH/«/g
s/|MI/»/g
s/|MJ/…/g
s/|MK/ /g
s/|ML/À/g
s/|MM/Ã/g
s/|MN/Õ/g
s/|MO/Œ/g
s/|MP/œ/g
s/|NA/–/g
s/|NB/—/g
s/|NC/“/g
s/|ND/”/g
s/|NE/‘/g
s/|NF/’/g
s/|NG/÷/g
s/|NH/◊/g
s/|NI/ÿ/g
s/|NJ/Ÿ/g
s/|NK/⁄/g
s/|NL/€/g
s/|NM/‹/g
s/|NN/›/g
s/|NO/ﬁ/g
s/|NP/ﬂ/g
s/|OA/‡/g
s/|OB/·/g
s/|OC/‚/g
s/|OD/„/g
s/|OE/‰/g
s/|OF/Â/g
s/|OG/Ê/g
s/|OH/Á/g
s/|OI/Ë/g
s/|OJ/È/g
s/|OK/Í/g
s/|OL/Î/g
s/|OM/Ï/g
s/|ON/Ì/g
s/|OO/Ó/g
s/|OP/Ô/g
s/|PA//g
s/|PB/Ò/g
s/|PC/Ú/g
s/|PD/Û/g
s/|PE/Ù/g
s/|PF/ı/g
s/|PG/ˆ/g
s/|PH/˜/g
s/|PI/¯/g
s/|PJ/˘/g
s/|PK/˙/g
s/|PL/˚/g
s/|PM/¸/g
s/|PN/˝/g
s/|PO/˛/g
s/|PP/ˇ/g
s/|HM/|/g
