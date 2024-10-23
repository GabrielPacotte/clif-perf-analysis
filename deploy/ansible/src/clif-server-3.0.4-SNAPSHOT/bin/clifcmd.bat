@echo off

set "__clifdir=%~dp0.."
set "__clif_opts="

if not exist paclif.opts copy "%__clifdir%\etc\paclif.opts" . >NUL
for /f "tokens=*" %%a in (paclif.opts) do (
	set __line=%%a
	call :processline
)

if "%1"=="analyze" goto analyze
if "%1"=="change" goto change
if "%1"=="collect" goto collect
if "%1"=="config" goto config
if "%1"=="deploy" goto deploy
if "%1"=="gui" goto gui
if "%1"=="help" goto help
if "%1"=="init" goto init
if "%1"=="join" goto join
if "%1"=="launch" goto launch
if "%1"=="listservers" goto listservers
if "%1"=="params" goto params
if "%1"=="probehelp" goto probehelp
if "%1"=="quickstats" goto quickstats
if "%1"=="registry" goto registry
if "%1"=="resume" goto resume
if "%1"=="run" goto run
if "%1"=="schedlaunch" goto schedlaunch
if "%1"=="server" goto server
if "%1"=="start" goto start
if "%1"=="stop" goto stop
if "%1"=="suspend" goto suspend
if "%1"=="version" goto version
if "%1"=="waitservers" goto waitservers

echo Invalid argument %1 in %0
goto usage

:analyze
	set __javacmd=org.ow2.clif.analyze.lib.graph.AnalyzerImpl
	goto suite
:change
	set __javacmd=org.ow2.clif.console.lib.batch.ChangeParameterCmd
	goto suite
:collect
	set __javacmd=org.ow2.clif.console.lib.batch.CollectCmd
	goto suite
:config
	set __javacmd=org.ow2.clif.util.ConfigFileManager paclif.opts
	goto suite
:deploy
	set __javacmd=org.ow2.clif.console.lib.batch.DeployCmd
	goto suite
:gui
	set __javacmd=org.ow2.clif.console.lib.gui.GuiConsoleImpl
	goto suite
:help
	goto usage
:init
	set __javacmd=org.ow2.clif.console.lib.batch.InitCmd
	goto suite
:join
	set __javacmd=org.ow2.clif.console.lib.batch.JoinCmd
	goto suite
:launch
	set __javacmd=org.ow2.clif.console.lib.batch.LaunchCmd
	goto suite
:listservers
	set __javacmd=org.ow2.clif.console.lib.batch.ListServersCmd
	goto suite
:params
	set __javacmd=org.ow2.clif.console.lib.batch.CurrentParametersCmd
	goto suite
:probehelp
	set __javacmd=org.ow2.clif.console.lib.batch.ProbeHelpCmd
	goto suite
:quickstats
	set __javacmd=org.ow2.clif.console.lib.batch.QuickstatsCmd
	goto suite
:registry
	set __javacmd=-Dproactive.pnp.port=1234 org.ow2.clif.console.lib.batch.RegistryCmd
	goto suite
:resume
	set __javacmd=org.ow2.clif.console.lib.batch.ResumeCmd
	goto suite
:run
	set __javacmd=org.ow2.clif.console.lib.batch.RunCmd
	goto suite
:schedlaunch
	set __javacmd=org.ow2.clif.console.lib.batch.LaunchWithSchedulerCmd
	goto suite
:server
	set __javacmd=org.ow2.clif.server.lib.ClifServerImpl
	goto suite
:start
	set __javacmd=org.ow2.clif.console.lib.batch.StartCmd
	goto suite
:stop
	set __javacmd=org.ow2.clif.console.lib.batch.StopCmd
	goto suite
:suspend
	set __javacmd=org.ow2.clif.console.lib.batch.SuspendCmd
	goto suite
:version
	wmic os get osarchitecture,caption /value |findstr =
	wmic cpu get name /value |findstr =
	java -version
	set __javacmd=org.ow2.clif.util.Version
	goto suite
:waitservers
	set __javacmd=org.ow2.clif.console.lib.batch.WaitServersCmd
	goto suite

:usage
echo usage: %0 command
echo available commands:
echo analyze
echo   Run the graphical reporting tool (CLIF Swing distribution only)
echo change testplan_name id param_name param_value
echo   Change an injector or probe parameter value
echo collect testplan_name [id1:id2:...idN]
echo   Collect measurements from a test run when it is terminated
echo config [registry_host[:registry_port] [codeserver_host[:codeserver_port]]]
echo   Update CLIF configuration file\n"
echo deploy testplan_name testplan_file
echo   Deploy a test plan
echo gui
echo   Run the graphical console (CLIF Swing distribution only)
echo help
echo   Print this help message
echo init testplan_name testrun_id
echo   Initialize a new test run
echo join testplan_name [id1:id2:...idN]
echo   Wait for the end of current test run
echo launch testplan_name testplan_file testrun_id
echo   Deploy and run a test plan, then collect measurements
echo listservers [test plan file names...]
echo   Either print the list of CLIF servers currently registered in the registry, or the list of CLIF servers used by some test plans
echo params testplan_name id
echo   Print an injector or probe's parameters list
echo probehelp probe_type
echo   Print some help for a given probe type
echo quickstats [report_directory]
echo   Print an array of response time statistics about the last test run
echo registry
echo   Run the CLIF/Fractal registry
echo resume testplan_name [id1:id2:...idN]
echo   Resume a test run
echo run testplan_name testrun_id [id1:id2:...idN]
echo   Initialize and start a new test run, then collect measurements
echo schedlaunch testplan_name testplan_file testrun_id [proactive workflow file]
echo   Deploy and run a test plan using ProActive Workflows And Scheduling, then collect measurements
echo server [name]
echo   Run a CLIF server
echo start testplan_name [id1:id2:...idN]
echo   Start a test run
echo stop testplan_name [id1:id2:...idN]
echo   Stop a test run
echo suspend testplan_name [id1:id2:...idN]
echo   Suspend a test run
echo version
echo   Print version information about CLIF and Java runtime
echo waitservers [testplan_file]
echo   Wait for CLIF registry and, optionally, all required CLIF servers to be ready
goto eof

:processline
if not %__line:~0,1%==# set __clif_opts=%__clif_opts% %__line%
goto eof

:suite
java -cp "%__clifdir%\lib\*;%__clifdir%\lib\ext\*;%__clifdir%\etc" %__clif_opts% %java_opts% -Djulia.loader=org.objectweb.fractal.julia.loader.DynamicLoader -Dfractal.provider=org.objectweb.fractal.julia.Julia -Djulia.config="%__clifdir%\etc\julia.cfg" -Djava.library.path="%__clifdir%\lib\sigar" -Djava.security.policy="%__clifdir%\etc\java.policy" %__javacmd% %2 %3 %4 %5
REM set __clifdir=
REM set __javacmd=
REM set __clif_opts=
REM set __line=

:eof
