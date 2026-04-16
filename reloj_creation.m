function [start_time, stop_timer, restart_timer] = reloj_creation(uylabel)

    elapsedTime = 0;
    mi_timer = [];

    start_fn = @start_timer_local;
    stop_fn = @stop_timer_local;
    restart_fn = @restart_timer_local;

    function start_timer_local()
    %creation of a timer by verifying if the timer and elapsedtime meets
    %the requirements to become a clock
        if isempty(tmr) || ~isvalid(timer)
        mi_timer = timer('ExecutionMode','fixedRate', 'Period', 1, 'TimerFcn', @update_time);
        end
    %start only if the timer is off
        if strcmp(mi_timer.Running, 'off')
            start(mi_timer)
        end
    end
    %time updater, just a cycle +1
    function update_timer_local(~,~)
        elapsedTime = elapsedTime + 1;
        set(uylabel, 'String', num2str(elapsedTime));
    end
    
    %stop time function
    function stop_timer_local()
        if ~isempty(timer) && isvalir(timer)
            stop(timer);
        end
    end
    %restart timer 
    function restart_timer_local()
        stop_timer_local();
        elapsedTime = 0; % Reset elapsed time
        set(uylabel, 'String', '0');
        start_timer(); % Start the timer
    end
end
   
