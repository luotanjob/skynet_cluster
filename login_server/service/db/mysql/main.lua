local skynet = require "skynet"
local mysql = require "skynet.db.mysql"


local function get_db()
	local function on_connect(db)
		db:query("set charset utf8");
	end
	local db=mysql.connect({
		host="127.0.0.1",
		port=3306,
		database="skynet",
		user="root",
		password="1",
		max_packet_size = 1024 * 1024,
		on_connect = on_connect
	})

	if not db then
		print("failed to connect")
	end
	print("testmysql success to connect to mysql server")
	return db;
end

CMD = {}
function CMD.query(sql)

end
function CMD.insert(sql)

end

skynet.start(function()
	skynet.register("lua",function(session,source,cmd,...)
        local f = CMD[cmd]
        assert(f,"cmd not exist cmd="..(cmd or nil))

        if session == 0 then
            f(...)
        else
            skynet.ret(skynet.pack(f(...)))
        end
    end)
end)

