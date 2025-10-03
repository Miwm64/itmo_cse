# -------------- Section 1 --------------
echo "Section 1"
# Directories
mkdir -p lab0/elgyem3/kadabra
mkdir -p lab0/krabby9/chandelure
mkdir lab0/krabby9/nidoranM
mkdir lab0/krabby9/roselia
mkdir -p lab0/vigoroth3/alakazam
mkdir lab0/vigoroth3/grotle
mkdir lab0/vigoroth3/leafeon

# --- Files in elgyem3 ---
touch lab0/elgyem3/mismagius
touch lab0/elgyem3/feraligatr
echo -e "Способности This is dummy text when pokemon does not\n contain something. It is better than NPE!" > lab0/elgyem3/mismagius
echo -e "satk=8 sdef=8\nspd=8" > lab0/elgyem3/feraligatr

# --- Files in lab0 ---
echo -e "Способности Swarm Mach Speed Shield Dust\nCompoundeyes" > lab0/mothim8
echo "Тип диеты Herbivore" > lab0/piloswine8
echo -e "Развитые\nспособности Contrary" > lab0/snivy9

# --- Files in krabby9 ---
echo "Тип диеты Herbivore" > lab0/krabby9/eevee
echo -e "Ходы After You Aqua Tail\nAvalanche Block Body Slam Brine Counter Dive Double-Edge Drain Punch\nDynamicpunch Focus Punch Foul Play Fury Cutter Hidden Power# Ice Punch\n Icy Wind Iron Defense Iron Tail Magic Coat Mega Kick Mega Punch\nMud-Slap Power Gem# Recycle Role Play Seismic Toss Signal Beam Skill\nSwap Sleep Talk Snore Swift Trick Wonder Room Zen\nHeadbutt" > lab0/krabby9/slowking

# --- Files in vigoroth3 ---
echo "satk=7 sdef=3 spd=6" > lab0/vigoroth3/horsea
echo -e "weight=166.7\nheight=63.0 atk=7 def=7" > lab0/vigoroth3/hypno

# -------------- Section 2 --------------
echo "Section 2"
# Permissions
chmod a-rwx lab0/elgyem3
chmod u+rwx,g+wx,o+rw lab0/elgyem3
chmod u=r,g=,o=r lab0/elgyem3/mismagius
chmod u=r,g=,o= lab0/elgyem3/feraligatr
chmod u+rwx,g=wx,o=wx lab0/elgyem3/kadabra
chmod 357 lab0/krabby9
chmod 315 lab0/krabby9/chandelure
chmod 440 lab0/krabby9/eevee
chmod 771 lab0/krabby9/nidoranM
chmod 440 lab0/krabby9/slowking
chmod u=rx,g=x,o=w lab0/krabby9/roselia
chmod u=rw,g=w,o= lab0/mothim8
chmod 046 lab0/piloswine8
chmod u=rw,g=w,o= lab0/snivy9
chmod a-rwx lab0/vigoroth3 
chmod u+wx,g+wx,o+rx lab0/vigoroth3
chmod 644 lab0/vigoroth3/horsea
chmod 330 lab0/vigoroth3/alakazam
chmod 755 lab0/vigoroth3/grotle
chmod u=wx,g=wx,o=rx lab0/vigoroth3/leafeon
chmod u=rw,g=w,o= lab0/vigoroth3/hypno



# -------------- Section 3 --------------
echo "Section 3"
# 1
cp -r lab0/elgyem3 lab0/elgyem3/kadabra

# 2
ln -s lab0/vigoroth3 lab0/Copy_81

# 3
ln lab0/snivy9 lab0/krabby9/eeveesnivy

# 4
ln -s lab0/mothim8 lab0/elgyem3/feraligatrmothim

# 5
cat lab0/vigoroth3/horsea lab0/krabby9/slowking > lab0/snivy9_48

# 6
cp lab0/mothim8 lab0/vigoroth3/horseamothim

# 7
cp lab0/snivy9 lab0/vigoroth3/grotle  

# -------------- Section 4 --------------
echo "Section 4"
#1
echo "4.1"
wc -l lab0/*[8] 2>&1
#2
echo "4.2"
chmod 777 lab0/krabby9 # Otherwise empty output
mkdir lab0/tmp
touch lab0/tmp/log.txt
ls -lp lab0/krabby9 | grep -v / | sort -k9r 2>>lab0/tmp/log.txt
chmod 357 lab0/krabby9
#3 
echo "4.3"
chmod 777 lab0/krabby9
grep -rh "" lab0 --include="e*" 2>/dev/null | sort -r                                    
chmod 357 lab0/krabby9
#4
echo "4.4"
ls -lR lab0 2>/dev/null | grep "ka" | grep -v ":$"

#1
ls -lR lab0 | grep -v ":$"| grep " [e][^ ]*$" | sort -k8r
#5
echo "4.6"
ls -lR lab0 2>>lab0/tmp/log.txt | grep -v ":$"| grep "a$" | sort -k8r

# -------------- Section 5 --------------
echo "Section 5"
rm lab0/snivy9
rm -f lab0/elgyem3/mismagius
rm lab0/elgyem3/feraligatrmoth*
rm lab0/krabby9/eeveesni*
rm -rf lab0/elgyem3
rmdir lab0/krabby9/nidoranM
