% Optitrack Matlab / NatNet Event Handler Sample
%  Requirements:
%   - OptiTrack Motive 2.0 or later
%   - OptiTrack NatNet 3.0 or later
%   - Matlab R2013
% This sample connects to the server and plots position and rotation of a
% single rigid body.
% natnet.p, needs to be located on the Matlab Path.

function NatNetEventHandlerSample
	global hf1 a1 a2 a3 a4 a5 a6
	global px py pz 
	global rx ry rz
    global px1 py1 pz1
    global xy
    global x y z 
	fprintf( 'NatNet Event Handler Sample Start\n' )

	CreatePlots;
	
	% create an instance of the natnet client class
	fprintf( 'Creating natnet class object\n' )
	natnetclient = natnet;

	% connect the client to the server (multicast over local loopback) -
	% modify for your network
	fprintf( 'Connecting to the server\n' )
	natnetclient.HostIP = '127.0.0.1';
	natnetclient.ClientIP = '127.0.0.1';
	natnetclient.ConnectionType = 'Multicast';
	natnetclient.connect;
	if ( natnetclient.IsConnected == 0 )
		fprintf( 'Client failed to connect\n' )
		fprintf( '\tMake sure the host is connected to the network\n' )
		fprintf( '\tand that the host and client IP addresses are correct\n\n' ) 
		return
	end


	% add some callback functions that execute autmatically in an
	% asynchronous manner to the event of a new frame of mocap data,
	% similar to how software interrupts operate.
	% callback functions block further execution of running code and a event handler buffer is created
	% with pending function callbacks to execute. Matlab by default is single threaded. 
	% callbacks are added to the event handler buffer in no particular order.
	fprintf( 'Adding four callback functions to execute with each frame of mocap\n' )
	addpath( 'event handlers')
	% first input is the listener slot and the second is the function
	% name, which must be an m file on the Matlab Path or current folder.
% 	natnetclient.addlistener( 1 , 'plotposition' );
	%natnetclient.addlistener( 2 , 'plotrotation' );
    %natnetclient.addlistener( 3 , 'plotxy1' );
    natnetclient.addlistener( 4 , 'plotmarkersposition' );
%     natnetclient.addlistener( 5 , 'plotmarkersposition2' );
%     natnetclient.addlistener( 6 , 'plotmarkersposition3' );

	% by default listeners/interrupts are disabled in the natnet class.
	% enable all listeners, 0, or individual listeners, 1, 2, etc.
	% Similiar for disabling
	fprintf( 'Enabling the listeners for asynchronous callback execution\n' )
	natnetclient.enable(0)


	% run for ? seconds, then disable the execution of further callbacks.
	% the rest of the event handler queue is executed.
	pause(30)
% 	fprintf( 'Disabling the listeners\n')
	natnetclient.disable(0)
	disp('NatNet Event Handler Sample End' )
	pause(3)
	close(hf1)
end


function CreatePlots
	% sets up two plots for viewing rigid body data, position and rotation
	global hf1 a1 a2 a3 a4 a5 a6
	% making animated lines global so they can be accessed in the
	% callback functions
	global px py pz
	global rx ry rz
    global px1 py1 pz1
    global xyz x2y2z2 x3y3z3 
    
	% create a figure which will contain two subplots
	hf1 = figure;
	hf1.WindowStyle = 'docked';

	% plot and animated line for position
% 	a1 = subplot( 1,2,1 );
% 	title( 'Position' );
% 	xlabel( 'Frame' )
% 	ylabel( 'Position (m)' )
% 
% 	px = animatedline;
% 	px.MaximumNumPoints = 1000;
% 	px.Marker = '.';
% 	px.LineWidth = 0.5;
% 	px.Color = [ 1 0 0 ];
% 
% 	py = animatedline;
% 	py.MaximumNumPoints = 1000;
% 	py.LineWidth = 0.5;
% 	py.Color = [ 0 1 0 ];
% 	py.Marker = '.';
% 
% 	pz = animatedline;
% 	pz.MaximumNumPoints = 1000;
% 	pz.LineWidth = 0.5;
% 	pz.Color = [ 0 0 1 ];
% 	pz.Marker = '.';

% 	% plot and animated line for rotation
% 	a2 = subplot( 2,2,2 );
% 	title( 'Rotation' );
% 	xlabel( 'Frame' )
% 	ylabel( 'Rotation (deg)' )
% 
% 	rx=animatedline;
% 	rx.MaximumNumPoints = 1000;
% 	rx.Marker = '.';
% 	rx.LineWidth = 0.5;
% 	rx.Color = [ 1 0 0 ];
% 
% 	ry = animatedline;
% 	ry.MaximumNumPoints = 1000;
% 	ry.Marker = '.';
% 	ry.LineWidth = 0.5;
% 	ry.Color = [ 0 1 0 ];
% 
% 	rz = animatedline;
% 	rz.MaximumNumPoints = 1000;
% 	rz.Marker = '.';
% 	rz.LineWidth = 0.5;
% 	rz.Color = [ 0 0 1];
%     
    % plot and animated line for x-y plane
    a4 = subplot( 1,1,1 );
	title( 'x-y-z' );
	xlabel( 'X' )
	ylabel( 'Y' )
    zlabel( 'Z' )
    hold on
    
    xyz = animatedline;
	xyz.MaximumNumPoints = 1000;
	xyz.Marker = '*';
	xyz.LineWidth = 0.5;
	xyz.Color = [ 0 0 1];
    
%     a5 = subplot( 1,1,1 );
%     hold on
%     
%     x2y2z2 = animatedline;
% 	x2y2z2.MaximumNumPoints = 1000;
% 	x2y2z2.Marker = 'o';
% 	x2y2z2.LineWidth = 0.5;
% 	x2y2z2.Color = [ 0 1 0];
%     
%     a6 = subplot( 1,1,1 );
%     hold on
%     
%     x3y3z3 = animatedline;
% 	x3y3z3.MaximumNumPoints = 1000;
% 	x3y3z3.Marker = '*';
% 	x3y3z3.LineWidth = 0.5;
% 	x3y3z3.Color = [ 1 0 0 ];
    
%     patch(xyz,x2y2z2,x3y3z3,'red');
    
    
%     %plot and animated line for marker1
%     a4 = subplot( 1,1,1 );
% 	title( 'Marker1' );
% 	xlabel( 'Frame' )
% 	ylabel( 'Position (m)' )
%     
%     px1 = animatedline;
% 	px1.MaximumNumPoints = 1000;
% 	px1.Marker = '.';
% 	px1.LineWidth = 0.5;
% 	px1.Color = [ 1 0 0 ];
% 
% 	py1 = animatedline;
% 	py1.MaximumNumPoints = 1000;
% 	py1.LineWidth = 0.5;
% 	py1.Color = [ 0 1 0 ];
% 	py1.Marker = '.';
% 
% 	pz1 = animatedline;
% 	pz1.MaximumNumPoints = 1000;
% 	pz1.LineWidth = 0.5;
% 	pz1.Color = [ 0 0 1 ];
% 	pz1.Marker = '.';
    
end


