function videoDouble(tempo, theta1, theta2, tempoTotal, L1, L2, filename)
    % entradas :
    % tempo : vetor contendo os instantes de tempo da simulacão
    % theta1 : vetor contando os estados (theta) da massa 1
    % theta2 : vetor contando os estados (theta) da massa 2
    % tempoTotal : tempo total da simulacão
    % L1: comprimento do fio (metros) da massa 1
    % L2: comprimento do fio (metros) da massa 2
    % filename: nome do arquivo
    writerObj = VideoWriter (strcat(filename, '.avi'), 'Motion JPEG AVI');
    writerObj.FrameRate = ceil(length(tempo) / tempoTotal);
    open (writerObj);
    fig = figure();
    ori = [0 0]; % origem do pêndulo
    for i = 1:length(tempo)
        % determine aqui as coordenadas do corpo para o caso não linear (use L)
        x1 = L1 * sin(theta1(i));
        y1 = - L1 * cos(theta1(i));
        % determine aqui as coordenadas do corpo para o caso linearizado (use L)
        x2 = x1 + L2 * sin(theta2(i));
        y2 = y1 - L2 * cos(theta2(i));

        axis ([-2 2 -2.5 0.5]);
        hold on;

        line([0 x1], [0 y1], 'Color', 'red');
        plot(x1, y1, 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'red');

        line([x1 x2], [y1 y2], 'Color', 'blue');
        plot(x2, y2, 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'blue');

        hold off;
        F = getframe;
        writeVideo(writerObj, F);
        clf(fig);
    end
    close (writerObj);
end
