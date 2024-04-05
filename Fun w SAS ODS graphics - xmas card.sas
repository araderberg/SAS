* Fun w/SAS ODS Graphics: A '2605'x, a '2605'x / Dancing in the night;

data stars;                                /* Create points for scatter plots */
input x y@@;                               /* Read x-y pairs of points for "stars" */
if x=3 & y=4 then color=2; else color=1;   /* Assign different color to one star */
y=y*.85;                                   /* Tighten up y-axis a smidgen */
xStand=2.5;                                /* Add points for "tree stand" */
yStand=1*.85;
datalines;
2.5 5 2 4 3 4 1.5 3 2.5 3 3.5 3 1 2 2 2 3 2 4 2
;

/* ods pdf file="xmascard.pdf" nogfootnote nogtitle notoc; */
ods pdf file="v:\xmascard.pdf" notoc;

title1 "Happy holidays, everyone:-)";
/* footnote1 "Happy holidays, everyone:-)"; */
title2 "Created by SAS version: &sysver";

ods graphics on / reset=index imagefmt=png antialias height=5in width=5in;  

ods html file="xmascard.html" style=journal gpath="v:\";

proc sgplot data=stars noautolegend noborder pad=0 aspect=1;
/* styleattrs datacontrastcolors=(CX085411 hotpink); */
styleattrs datacontrastcolors=(CX085411 red);
symbolchar name=uniStar char='2605'x;      /* Unicode for 5-pointed star */
symbolchar name=uniRectangle char='25AE'x; /* Unicode for vertical rectangle */
xaxis display=none offsetmin=0 offsetmax=0 values=(0 5);
yaxis display=none offsetmin=0 offsetmax=0 values=(.005 5);
scatter x=x y=y /                          /* Stars */
        markerattrs=(symbol=unistar size=116pt) group=color; 
scatter x=xStand y=yStand /                /* Tree stand */
        markerattrs=(symbol=unirectangle color=CX085411 size=116pt);
footnote;
ods pdf close;
ods html close;

