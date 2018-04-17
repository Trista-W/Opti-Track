
function plotmarkersposition( ~ , evnt )
	% The event callback function executs each time a frame of mocap data is delivered.
	% to Matlab. Matlab will lag if the data rate from the Host is too high.
	% A simple animated line graphs the x, y, z position of the first rigid body on the Host.

	
	% Note - This callback uses the gobal variables px, py, pz from the NatNetEventHandlerSample.
% 	global px1
% 	global py1  
% 	global pz1 
    global xyz
	global a4
	
	% local variables
	persistent frame4
	persistent lastframe4
    MarkerID = 1;
	
	
	% Get the frame number
	frame4 = double( evnt.data.iFrame );
% 	if ~isempty( frame4 ) && ~isempty( lastframe4 )
% 		if frame4 < lastframe4
% 			px1.clearpoints;
% 			py1.clearpoints;
% 			pz1.clearpoints;
% 		end
% 	end
            xyz.clearpoints;
	
	% Get the markers position
    Pos = zeros(3,3);
    for i = 1:3
        Pos(1,i) = double( evnt.data.LabeledMarkers( i ).x );  % [x1 x2 x3]
        Pos(2,i) = double( evnt.data.LabeledMarkers( i ).y );  % [y1 y2 y3]
        Pos(3,i) = double( evnt.data.LabeledMarkers( i ).z );  % [z1 z2 z3]
    end
	
	% Fill the animated line's queue with the markers position
	frame = frame4;
% 	px1.addpoints( frame , x1 );
% 	py1.addpoints( frame , y1 );
% 	pz1.addpoints( frame , z1 );
    for i = 1:3
        xyz.addpoints(Pos(1,i),Pos(2,i),Pos(3,i));
    end
    xyz.addpoints(Pos(1,1),Pos(2,1),Pos(3,1));

	% set the figure and subplot to graph the data
	set( gcf , 'CurrentAxes' , a4 )

	
	% Dynamically move the axis of the graph
% 	axis( [ -240 + frame , 20 + frame , min( x , min( y , z ) ) - scope , max( x , max( y , z ) ) + scope] );
    axis([-1,1,-1,1.5,-1,1.5]);

	
	% Draw the data to a figure
	drawnow
	
	
	% Update lastframe
	lastframe4 = frame4;
end  % eventcallback1
