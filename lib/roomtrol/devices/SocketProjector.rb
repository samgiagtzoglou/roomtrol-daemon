#---
#{
#	"name": "SocketProjector",
#	"depends_on": "SocketDevice",
#	"description": "Generic socket projector class - used to control a projector over a TCP socket connection",
#	"author": "Jonathan Lyons",
#	"email": "jclyons@wesleyan.edu",
#	"abstract": true,
#	"type": "Projector"
#}
#---

class SocketProjector < Wescontrol::SocketDevice

	@interface = "Projector"

	state_var :power,       :type => :boolean, :display_order => 1#, :on_change => proc{|on|
	#	if on
	#		turned_on = Time.now
	#	else
	#		turned_off = Time.now
	#	end
	#}
	state_var :video_mute,  :type => :boolean, :display_order => 4
	state_var :input,       :type => :option, :options => ['RGB1','RGB2','VIDEO','SVIDEOb'], :display_order => 2
	state_var :brightness,  :type => :percentage, :display_order => 3
	state_var :cooling,     :type => :boolean, :editable => false
	state_var :warming,     :type => :boolean, :editable => false
	state_var :model,       :type => :string, :editable => false
	state_var :lamp_hours,  :type => :number, :editable => false
	state_var :filter_hours,:type => :number, :editable => false
	state_var :percent_lamp_used, :type => :percentage, :editable => false
	state_var :operational, :type => :boolean
	#state_var :turned_on,  :type => :time', :editable => false
	#state_var :turned_off,	:type => :time', :editable => false
	
	virtual_var :lamp_remaining, :type => :string, :depends_on => [:lamp_hours, :percent_lamp_used], :transformation => proc {
		"#{((lamp_hours/percent_lamp_used - lamp_hours)/(60*60.0)).round(1)} hours"
	}, :display_order => 6
	
	virtual_var :state, :type => :string, :depends_on => [:power, :warming, :cooling, :video_mute], :transformation => proc {
		warming ? "warming" :
			cooling ? "cooling" :
				!power ? "off" :
					video_mute ? "muted" : "on"	    
	}
	
	#time_since_var :on_time, :since => :turned_on, :before => :turned_off
	#virtual_var :on_time, :type => 'decimal', :depends_on => [:turned_on], :transformation => proc {
	#	(Time.now-turned_on)/(60*60) #Time.- returns seconds; converted to hours
	#}

end
