
function plotmarkersposition( ~ , evnt )
	% The event callback function executs each time a frame of mocap data is delivered.
	% to Matlab. Matlab will lag if the data rate from the Host is too high.
	% A simple animated line graphs the x, y, z position of the first rigid body on the Host.

	
	% Note - This callback uses the gobal variables px, py, pz from the NatNetEventHandlerSample.
% 	global px1
% 	global py1  
% 	global pz1 
    global x3y3z3
	global a6
	
	% local variables
	persistent frame6
	persistent lastframe6
    MarkerID = 3;
	
	
	% Get the frame number
	frame6 = double( evnt.data.iFrame );
% 	if ~isempty( frame6 ) && ~isempty( lastframe6 )
% 		if frame6 < lastframe6
% 			px1.clearpoints;
% 			py1.clearpoints;
% 			pz1.clearpoints;
% 		end
% 	end
            x3y3z3.clearpoints;
	
	% Get the markers position
	x3 = double( evnt.data.LabeledMarkers( MarkerID ).x );
	y3 = double( evnt.data.LabeledMarkers( MarkerID ).y );
	z3 = double( evnt.data.LabeledMarkers( MarkerID ).z );
    
	
	% Fill the animated line's queue with the markers position
	frame = frame6;
% 	px1.addpoints( frame , x1 );
% 	py1.addpoints( frame , y1 );
% 	pz1.addpoints( frame , z1 );
    x3y3z3.addpoints(x3,y3,z3)


	% set the figure and subplot to graph the data
	set( gcf , 'CurrentAxes' , a6 )

	
	% Dynamically move the axis of the graph
% 	axis( [ -240 + frame , 20 + frame , min( x , min( y , z ) ) - scope , max( x , max( y , z ) ) + scope] );
    axis([-1,1,-1,1.5,-1,1.5]);

	
	% Draw the data to a figure
	drawnow
	
	
	% Update lastframe
	lastframe6 = frame6;
end  % eventcallback1
