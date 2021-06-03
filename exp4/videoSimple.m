function videoSimple(tempo, theta_nonlienar, theta_linear, tempoTotal, L, filename)
    % entradas :
    % tempo : vetor contendo os instantes de tempo da simulacão
    % theta_nonlienar : vetor contando os estados (theta) da simulação não linear
    % theta_linear : vetor contando os estados (theta) da simulacão linear
    % tempoTotal : tempo total da simulacão
    % L: comprimento do fio (metros)
    % filename: nome do arquivo
    writerObj = VideoWriter (strcat(filename, '.avi'), 'Motion JPEG AVI');
    writerObj.FrameRate = ceil(length(tempo) / tempoTotal);
    open (writerObj);
    fig = figure();
    ori = [0 0]; % origem do pêndulo
    for i = 1:length(tempo)
        % determine aqui as coordenadas do corpo para o caso não linear (use L)
        x_nonlinear = L * sin(theta_nonlienar(i));
        y_nonlinear = - L * cos(theta_nonlienar(i));
        % determine aqui as coordenadas do corpo para o caso linearizado (use L)
        x_linear = L * sin(theta_linear(i));
        y_linear = - L * cos(theta_linear(i));

        axis ([-2 2 -2.5 0.5]);
        hold on;

        line([0 x_nonlinear], [0 y_nonlinear], 'Color', 'red');
        plot(x_nonlinear, y_nonlinear, 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'red');

        line([0 x_linear], [0 y_linear], 'Color', 'blue');
        plot(x_linear, y_linear, 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'blue');

        hold off;
        F = getframe;
        writeVideo(writerObj, F);
        clf(fig);
    end
    close (writerObj);
end
