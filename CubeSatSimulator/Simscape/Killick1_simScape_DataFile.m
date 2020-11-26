% Simscape(TM) Multibody(TM) version: 5.1

% This is a model data file derived from a Simscape Multibody Import XML file using the smimport function.
% The data in this file sets the block parameter values in an imported Simscape Multibody model.
% For more information on this file, see the smimport function help page in the Simscape Multibody documentation.
% You can modify numerical values, but avoid any other changes to this file.
% Do not add code to this file. Do not edit the physical units shown in comments.

%%%VariableName:smiData


%============= RigidTransform =============%

%Initialize the RigidTransform structure array by filling in null values.
smiData.RigidTransform(9).translation = [0.0 0.0 0.0];
smiData.RigidTransform(9).angle = 0.0;
smiData.RigidTransform(9).axis = [0.0 0.0 0.0];
smiData.RigidTransform(9).ID = '';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(1).translation = [27.238339546544999 27.238339546541951 -50.527425013801704];  % mm
smiData.RigidTransform(1).angle = 2.0031414340907623;  % rad
smiData.RigidTransform(1).axis = [0.072323175446861121 0.54339580320655378 0.83635540253578011];
smiData.RigidTransform(1).ID = 'B[body_part_acis-1:-:wheel_part_acis-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(2).translation = [2.6749999999999194 -3.7747582837255322e-15 5.6399329650957952e-14];  % mm
smiData.RigidTransform(2).angle = 2.0943951023931962;  % rad
smiData.RigidTransform(2).axis = [0.57735026918962595 0.57735026918962595 0.57735026918962551];
smiData.RigidTransform(2).ID = 'F[body_part_acis-1:-:wheel_part_acis-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(3).translation = [-27.23833954654625 27.238339546542399 -50.527425013801];  % mm
smiData.RigidTransform(3).angle = 1.2205475376179569;  % rad
smiData.RigidTransform(3).axis = [-0.30833373313452539 -0.74438348027047141 -0.5923035904937165];
smiData.RigidTransform(3).ID = 'B[body_part_acis-1:-:wheel_part_acis-2]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(4).translation = [2.6749999999998293 -2.8199664825478976e-14 2.9531932455029164e-14];  % mm
smiData.RigidTransform(4).angle = 2.0943951023931957;  % rad
smiData.RigidTransform(4).axis = [0.57735026918962595 0.57735026918962584 0.57735026918962551];
smiData.RigidTransform(4).ID = 'F[body_part_acis-1:-:wheel_part_acis-2]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(5).translation = [-27.238339546546499 -27.238339546549199 -50.527425013800197];  % mm
smiData.RigidTransform(5).angle = 1.2205475376179269;  % rad
smiData.RigidTransform(5).axis = [0.30833373313451667 -0.74438348027047596 0.59230359049371528];
smiData.RigidTransform(5).ID = 'B[body_part_acis-1:-:wheel_part_acis-3]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(6).translation = [2.674999999999816 3.219646771412954e-14 6.7723604502134549e-14];  % mm
smiData.RigidTransform(6).angle = 2.0943951023931962;  % rad
smiData.RigidTransform(6).axis = [0.57735026918962595 0.57735026918962606 0.57735026918962518];
smiData.RigidTransform(6).ID = 'F[body_part_acis-1:-:wheel_part_acis-3]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(7).translation = [27.238339546544548 -27.238339546549447 -50.527425013801];  % mm
smiData.RigidTransform(7).angle = 1.578218682204158;  % rad
smiData.RigidTransform(7).axis = [0.64491413491737604 0.085834741182307703 0.75941961772786648];
smiData.RigidTransform(7).ID = 'B[body_part_acis-1:-:wheel_part_acis-4]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(8).translation = [2.6749999999998577 6.6613381477509392e-15 4.3298697960381105e-14];  % mm
smiData.RigidTransform(8).angle = 2.0943951023931957;  % rad
smiData.RigidTransform(8).axis = [0.57735026918962584 0.57735026918962584 0.57735026918962562];
smiData.RigidTransform(8).ID = 'F[body_part_acis-1:-:wheel_part_acis-4]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(9).translation = [0 0 0];  % mm
smiData.RigidTransform(9).angle = 0;  % rad
smiData.RigidTransform(9).axis = [0 0 0];
smiData.RigidTransform(9).ID = 'RootGround[body_part_acis-1]';

%Overall CoM Transform
%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(10).translation = [-8.1765370500846988 -0.15452898045054561 15.369806189285557];  % mm
smiData.RigidTransform(10).angle = 0;  % rad
smiData.RigidTransform(10).axis = [0 0 0];
smiData.RigidTransform(10).ID = 'UCS[Killick1_simScape:BODY FIXED CoM]';


%============= Solid =============%
%Center of Mass (CoM) %Moments of Inertia (MoI) %Product of Inertia (PoI)

%Initialize the Solid structure array by filling in null values.
smiData.Solid(2).mass = 0.0;
smiData.Solid(2).CoM = [0.0 0.0 0.0];
smiData.Solid(2).MoI = [0.0 0.0 0.0];
smiData.Solid(2).PoI = [0.0 0.0 0.0];
smiData.Solid(2).color = [0.0 0.0 0.0];
smiData.Solid(2).opacity = 0.0;
smiData.Solid(2).ID = '';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(1).mass = 0.60800410888653389;  % kg
smiData.Solid(1).CoM = [13.153872808257988 0.24859601829025302 8.6173954257348946];  % mm
smiData.Solid(1).MoI = [4414.351 3336.736 2849.774];  % kg*mm^2
smiData.Solid(1).PoI = [-1.701 96.057 0.572];  % kg*mm^2
smiData.Solid(1).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(1).opacity = 1;
smiData.Solid(1).ID = 'body_part_acis*:*Default';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(2).mass = 0.092528158690945092;  % kg
smiData.Solid(2).CoM = [-4.7301992759464113 0 0];  % mm
smiData.Solid(2).MoI = [37.628 19.934 19.934];  % kg*mm^2
smiData.Solid(2).PoI = [0 0 0];  % kg*mm^2
smiData.Solid(2).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(2).opacity = 1;
smiData.Solid(2).ID = 'wheel_part_acis*:*Default';


%============= Joint =============%
%X Revolute Primitive (Rx) %Y Revolute Primitive (Ry) %Z Revolute Primitive (Rz)
%X Prismatic Primitive (Px) %Y Prismatic Primitive (Py) %Z Prismatic Primitive (Pz) %Spherical Primitive (S)
%Constant Velocity Primitive (CV) %Lead Screw Primitive (LS)
%Position Target (Pos)

%Initialize the RevoluteJoint structure array by filling in null values.
smiData.RevoluteJoint(4).Rz.Pos = 0.0;
smiData.RevoluteJoint(4).ID = '';

smiData.RevoluteJoint(1).Rz.Pos = -144.99811669036046;  % deg
smiData.RevoluteJoint(1).ID = '[body_part_acis-1:-:wheel_part_acis-1]';

smiData.RevoluteJoint(2).Rz.Pos = -12.256087877978665;  % deg
smiData.RevoluteJoint(2).ID = '[body_part_acis-1:-:wheel_part_acis-2]';

smiData.RevoluteJoint(3).Rz.Pos = 165.90188982570191;  % deg
smiData.RevoluteJoint(3).ID = '[body_part_acis-1:-:wheel_part_acis-3]';

smiData.RevoluteJoint(4).Rz.Pos = 135.92724186514309;  % deg
smiData.RevoluteJoint(4).ID = '[body_part_acis-1:-:wheel_part_acis-4]';

