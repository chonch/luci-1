module("luci.statistics.rrdtool.definitions.netlink", package.seeall)

function rrdargs( graph, plugin, plugin_instance )

	--
	-- traffic diagram
	--
	local traffic = {

		-- diagram title
		title	= "Verkehr",

		-- vertical label
		vlabel  = "Bytes/s",

		-- diagram data description
		data = {
			-- defined sources for data types, if ommitted assume a single DS named "value" (optional)
			sources = {
				if_octets = { "tx", "rx" }
			},

			-- special options for single data lines
			options = {
				if_octets__tx = {
					total = true,		-- report total amount of bytes
					color = "00ff00"	-- tx is green
				},

				if_octets__rx = {
					flip  = true,		-- flip rx line
					total = true,		-- report total amount of bytes
					color = "0000ff"	-- rx is blue
				}
			}
		}
	}


	--
	-- packet diagram
	--
	local packets = {

		-- diagram title
		title	= "Pakete",

		-- vertical label
		vlabel  = "Pakete/s",

		-- diagram data description
		data = {
			-- data type order
			types = { "if_packets", "if_dropped", "if_errors" },

			-- defined sources for data types
			sources = {
				if_packets = { "tx", "rx" },
				if_dropped = { "tx", "rx" },
				if_errors  = { "tx", "rx" }
			},

			-- special options for single data lines
			options = {
				-- processed packets (tx DS)
				if_packets__tx = {
					overlay = true,		-- don't summarize
					total   = true,		-- report total amount of bytes
					color   = "00ff00"	-- processed tx is green
				},

				-- processed packets (rx DS)
				if_packets__rx = {
					overlay = true,		-- don't summarize
					flip    = true,		-- flip rx line
					total   = true,		-- report total amount of bytes
					color   = "0000ff"	-- processed rx is blue
				},

				-- dropped packets (tx DS)
				if_dropped__tx = {
					overlay = true,		-- don't summarize
					total   = true,		-- report total amount of bytes
					color   = "660055"	-- dropped tx is ... dunno ;)
				},

				-- dropped packets (rx DS)
				if_dropped__rx = {
					overlay = true,		-- don't summarize
					flip    = true,		-- flip rx line
					total   = true,		-- report total amount of bytes
					color   = "440066"	-- dropped rx is violett
				},

				-- packet errors (tx DS)
				if_errors__tx = {
					overlay = true,		-- don't summarize
					total   = true,		-- report total amount of packets
					color   = "ff5500"	-- tx errors are orange
				},

				-- packet errors (rx DS)
				if_errors__rx = {
					overlay = true,		-- don't summarize
					flip    = true,		-- flip rx line
					total   = true,		-- report total amount of packets
					color   = "ff0000"	-- rx errors are red
				}
			}
		}
	}


	--
	-- multicast diagram
	--
	local multicast = {

		-- diagram title
		title	= "Multicast-Pakete",

		-- vertical label
		vlabel  = "Pakete/s",

		-- diagram data description
		data = {
			-- data type order
			types = { "if_multicast" },

			-- special options for single data lines
			options = {
				-- multicast packets
				if_multicast = {
					total = true,		-- report total amount of packets
					color = "0000ff"	-- multicast is blue
				}
			}
		}
	}


	--
	-- collision diagram
	--
	local collisions = {

		-- diagram title
		title	= "Paketkollisionen",

		-- vertical label
		vlabel  = "Kollisionen/s",

		-- diagram data description
		data = {
			-- data type order
			types = { "if_collisions" },

			-- special options for single data lines
			options = {
				-- collision rate
				if_collisions = {
					total = true,		-- report total amount of packets
					color = "ff0000"	-- collsions are red
				}
			}
		}
	}


	--
	-- error diagram
	--
	local errors = {

		-- diagram title
		title	= "TX/RX-Fehler",

		-- vertical label
		vlabel  = "Kollisionen/s",

		-- diagram data description
		data = {
			-- data type order
			types = { "if_tx_errors", "if_rx_errors" },

			-- data type instances
			instances = {
				if_tx_errors = { "aborted", "carrier", "fifo", "heartbeat", "window" },
				if_rx_errors = { "length", "missed", "over", "crc", "fifo", "frame" }
			},

			-- special options for single data lines
			options = {	-- XXX: fixme (define colors...)
				if_tx_errors = {
					total = true
				},

				if_rx_errors = {
					flip  = true,
					total = true
				}
			}
		}
	}


	return { traffic, packets, multicast, collisions, errors }
end
