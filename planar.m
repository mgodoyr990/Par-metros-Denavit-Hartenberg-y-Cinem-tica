clear
close
clc

L1=Revolute('a',20,'alpha',0,'d',0);
L2=Revolute('a',10,'alpha',0,'d',0);

bot=SerialLink([L1,L2]);

bot.fkine([pi/2,0]) %
bot.links
bot.teach([pi/2,0], 'noname'); 
