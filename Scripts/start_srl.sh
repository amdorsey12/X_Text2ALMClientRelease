#!/bin/bash
echo "Starting Srl"
cd resources/srl-4.31/srl-20131216
sh scripts/run_http_server.sh 8071 '../../models/eng/'

