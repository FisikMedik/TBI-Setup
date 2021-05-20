%% Ilustration of the TBI SetUp
% Stablishing the fixed values:
SAD=100; % Source to Axis Distance.
ACD=106.5; % Axis to Couch Distance.
ASD=81.5; % Axis to Skin Distance, 25 cm patient thickness.
CHD=60; % Center to Head (or hands) Distance.
CTD=120; % Center to toes Distance.
patient=imread('Patient.jpeg');
ang=30;
Th=0:ang;

% Generating an arc of 30º
xang=20*sin(Th*pi/180);
yang=20*cos(Th*pi/180);

% Generating an arc of 11.31ª=atan(20/100)
phi=180*atan(1/5)/pi;
Th=(ang-phi):ang;
xphi=45*sin(Th*pi/180);
yphi=45*cos(Th*pi/180);

% Definition of vector coordinates for the beam representation
SourceX=SAD*sin(ang*pi/180);
SourceY=ACD+SAD*cos(ang*pi/180);
MidX=-(SAD*sin(ang*pi/180)+ACD*tan(ang*pi/180));
MidY=-(ACD+SAD*cos(ang*pi/180));
RightX=MidY*tan((ang-180*atan(1/5)/pi)*pi/180);
RightY=MidY;
LeftX=MidY*tan((ang+180*atan(1/5)/pi)*pi/180);
LeftY=MidY;

% Plotting everything
figure
hold on;
% Plotting the imported image
imagesc([-120 65.5], [30 0], patient); % Inverted 'y' coordinates

% Plotting the beam:
quiver(SourceX,SourceY,MidX,MidY,0,'--or');
quiver(SourceX,SourceY,RightX,RightY,0,'-or');
quiver(SourceX,SourceY,LeftX,LeftY,0,'-or');

% Plotting the center
plot(0,ACD, 'g*','MarkerSize',10);
% Stablishing the axis limits
axis([-130 110 -15 225]);
% Plotting the trajectory of the source
viscircles([0 ACD],SAD, 'LineStyle',':', 'Color', 'b','LineWidth',1);
% Keeping the proportions of the axis
pbaspect([1 1 1]); % For avoiding deformation
grid on; grid minor;

% Labeling
title("Total Body Irradiation Arc Therapy", 'Sagital View');
xlabel('Z-axial'); ylabel('X-coronal');

% labeling the isocenter
isocenter = '\leftarrow Isocenter';
text(0,ACD,isocenter, 'color', [0.1 0.9 0.5],'FontSize',14)
% labeling the source
source = '\leftarrow Source';
text(SourceX,SourceY,source, 'color', [0.1 0.9 0.5],'FontSize',14)

% Labeling the angles \theta
angtext = '\theta';
plot(xang,ACD+yang);
text(5,ACD+25,angtext,'FontSize',14)
plot(SourceX-xang,SourceY-yang,'b');
text(SourceX-max(xang)+2,SourceY-max(yang)-5,angtext,'FontSize',14)

% Labeling the angle \phi
phitext = '\phi';
plot(SourceX-xphi,SourceY-yphi,'b');
text(SourceX-max(xphi)-2,SourceY-max(yphi)-5,phitext,'FontSize',14)

% Axis to Couch Distance
quiver(-SAD-20,ACD,0,-ACD,0,'-+k');
quiver(-SAD-20,0,0,ACD,0,'-+k');
quiver(-SAD-20,ACD,SAD+20,0,0,':k','Marker','.', 'ShowArrowHead', 'off');
text(-SAD-15,ACD/2,'ACD', 'color','k','FontSize',12)

% Source to Axis Distance
quiver(0,SAD+ACD+10,-SAD,0,0,'-+k');
quiver(-SAD,SAD+ACD+10,SAD,0,0,'-+k');
quiver(-SAD,SAD+ACD+10,0,-SAD-10,0,':k','Marker','.', 'ShowArrowHead', 'off');
quiver(0,SAD+ACD+10,0,-SAD-10,0,':k','Marker','.', 'ShowArrowHead', 'off');
text(-SAD/2,SAD+ACD+5,'SAD', 'color','k','FontSize',12, 'HorizontalAlignment', 'Center');

% Field Size at the Isocenter = 20 cm in this case.
quiver(0,ACD,-20*cos(ang*pi/180),20*sin(ang*pi/180),0,'-+k');
quiver(-20*cos(ang*pi/180),ACD+20*sin(ang*pi/180),20*cos(ang*pi/180),-20*sin(ang*pi/180),0,'-+k');
text(-10*cos(ang*pi/180),ACD,'FSI', 'color','k','FontSize',12, 'HorizontalAlignment', 'Right');

hold off;
