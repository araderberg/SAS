* Fun w/SAS ODS Graphics: Solar Eclipse "Time-Lapse" (SGPANEL + BUBBLE Plots)

  Inspired by forum.timescapes.org/phpBB3/viewtopic.php?f=4&t=7775;
 
data eclipse;                                /* Generate points for sun/moon */
do frame=1 to 11;                            /* At 11 different times/locations */
  sunX=.5; sunY=.5; sz=50; output;           /* Sun plotted at constant position in frame */
  sunX=.; sunY=.;
  if frame<=6 then                           /* Sun goes behind moon in first 6 frames */
    moonX=.5+(6-frame)*(.775/5);
  else                                       /* Sun emerges from behind moon in last 5 frames */
    moonX=.5-(frame-6)*(.775/5);
  moonY=.5; sz=40; output;                   /* Make moon slightly smaller bubble than sun */
  moonX=.; moonY=.;
  sz=1; output;                              /* "Dummy" points with size=1 make sun/moon bigger */
end;
 
ods listing gpath='/folders/myfolders';      /* Use SGPANEL to plot frames in one image */
ods graphics on / reset antialias width=10in height=1in imagename="ECLIPSE";

proc sgpanel data=eclipse noautolegend;      /* "Time-lapse" is 1x11 panel of bubble plots */
styleattrs backcolor=black wallcolor=black;
panelby frame / rows=1 columns=11 onepanel noheader noheaderborder noborder;
bubble x=sunX y=sunY size=sz / colormodel=(yelloworange) colorresponse=sunX dataskin=sheen bradiusmax=50;
bubble x=moonX y=moonY size=sz / colormodel=(black) colorresponse=moonX dataskin=sheen bradiusmax=50;
rowaxis display=none; 
colaxis display=none values=(0 to 1) min=0 max=1 offsetmin=0 offsetmax=0;
run;
 
