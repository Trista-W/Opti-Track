
function plotxy1( ~ , evnt )
	% The event callback function executs each time a frame of mocap data is delivered.
	% to Matlab. Matlab will lag if the data rate from the Host is too high.
	% A simple animated line graphs the x, y, z position of the first rigid body on the Host.

	
	% Note - This callback uses the gobal variables px, py, pz from the NatNetEventHandlerSample.
	
	global a3
	global xy
    
	% local variables
	persistent frame3
	persistent lastframe3
	scope = 1.5;
	rbnum = 1;
	
	
	% Get the frame number
	frame3 = double( evnt.data.iFrame );
    xy.clearpoints;

	
	% Get the rigid body position
	x = double( evnt.data.RigidBodies( rbnum ).x );
	y = double( evnt.data.RigidBodies( rbnum ).y );
	%change the prospective by multiplying the cos/sin angle  
	
	% Fill the animated line's queue with the rb position
	frame = frame3;
	%px.addpoints( frame , x );
	%py.addpoints( frame , y );
	%pz.addpoints( frame , z );
    xy.addpoints(x,y);
	
	% set the figure and subplot to graph the data
	set( gcf , 'CurrentAxes' , a3 )

	
	% Dynamically move the axis of the graph
	%axis( [ -240 + frame ,  20 + frame , min( x , min( y , z ) ) - scope , max( x , max( y , z ) ) + scope ] );
    axis([-1,1,0,1.5]);
 
	
	% Draw the data to a figure
	drawnow
	
	
	% Update lastframe
	lastframe3 = frame3;
end  % eventcallback3
