module Wescontrol
	class WescontrolLab < Wescontrol
		def initialize
			puts "Initializing lab controller"
			begin
				@controller = Controller.find_by_mac(MAC.addr)
				throw "Controller Does Not Exist" unless @controller
			rescue
				raise "The controller has not been added the database"
			end

			device_hashes = Controller.devices(@controller["id"])
			@couchid = @controller["id"]
			super(device_hashes)
		end
	end
	
	class Controller
		@database = "http://localhost:5984/rooms"
		
		def self.find_by_mac(mac, db_uri = @database)
			db = CouchRest.database(db_uri)
			retried = false
			begin
				db.get("_design/controller").view("by_mac", {:key => mac})['rows'][0]
			rescue RestClient::ResourceNotFound
				Controller.define_db_views(db_uri)
				if !retried #prevents infinite retry loop
					retried = true
					retry
				end
				nil
			rescue
				nil
			end
		end
		
		def self.devices(controller, db_uri = @database)
			db = CouchRest.database(db_uri)
			retried = false
			begin
				db.get("_design/controller").view("devices_for_controller", {:key => controller})['rows']
			rescue RestClient::ResourceNotFound
				Controller.define_db_views(db_uri)
				if !retried #prevents infinite retry loop
					retried = true
					retry
				end
				nil
			rescue
				nil
			end
		end
		
		def self.define_db_views(db_uri)
			db = CouchRest.database(db_uri)

			doc = {
				"_id" => "_design/controller",
				:views => {
					:by_mac => {
						:map => "function(doc) {
							if(doc.attributes && doc.attributes[\"mac\"]){
								emit(doc.attributes[\"mac\"], doc);
							}
						}".gsub(/\s/, "")
					},
					:devices_for_controller => {
						:map => "function(doc) {
							if(doc.controller && doc.device)
							{
								emit(doc.controller, doc);
							}
						}".gsub(/\s/, "")
					}
				}
			}
			begin 
				doc["_rev"] = db.get("_design/controller").rev
			rescue
			end
			db.save_doc(doc)
		end
	end
end
