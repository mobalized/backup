[LUA]@echo off
title OTserv Auto-restarter
echo :: --- Auto-Restarter ---
echo :: %date%
echo :: %time%
:begin
theforgottenserver.exe
echo :: --- Server Restarted ---
echo :: %date%
echo :: %time%
goto begin
:goto begin[/LUA] 