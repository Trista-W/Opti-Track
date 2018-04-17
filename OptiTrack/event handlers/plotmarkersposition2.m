
function plotmarkersposition( ~ , evnt )
	% The event callback function executs each time a frame of mocap data is delivered.
	% to Matlab. Matlab will lag if the data rate from the Host is too high.
	% A simple animated line graphs the x, y, z position of the first rigid body on the Host.

	
	% Note - This callback uses the gobal variables px, py, pz from the NatNetEventHandlerSample.
% 	global px1
% 	global py1  
% 	global pz1 
    global x2y2z2
	global a5
	
	% local variables
	persistent frame5
	persistent lastframe5
    MarkerID = 2;
	
	
	% Get the frame number
	frame5 = double( evnt.data.iFrame );
% 	if ~isempty( frame5 ) && ~isempty( lastframe5 )
% 		if frame5 < lastframe5
% 			px1.clearpoints;
% 			py1.clearpoints;
% 			pz1.clearpoints;
% 		end
% 	end
            x2y2z2.clearpoints;
	
	% Get the markers position
	x2 = double( evnt.data.LabeledMarkers( MarkerID ).x );
	y2 = double( evnt.data.LabeledMarkers( MarkerID ).y );
	z2 = double( evnt.data.LabeledMarkers( MarkerID ).z );
    
	
	% Fill the animated line's queue with the markers position
	frame = frame5;
% 	px1.addpoints( frame , x1 );
% 	py1.addpoints( frame , y1 );
% 	pz1.addpoints( frame , z1 );
    x2y2z2.addpoints(x2,y2,z2)


	% set the figure and subplot to graph the data
	set( gcf , 'CurrentAxes' , a5 )

	
	% Dynamically move the axis of the graph
% 	axis( [ -240 + frame , 20 + frame , min( x , min( y , z ) ) - scope , max( x , max( y , z ) ) + scope] );
    axis([-1,1,-1,1.5,-1,1.5]);

	
	% Draw the data to a figure
	drawnow
	
	
	% Update lastframe
	lastframe5 = frame5;
end  % eventcallback1
