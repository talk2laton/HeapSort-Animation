function A = HeapSort(A, animate)
    close all;  n = numel(A); handles = [];
    if(animate)
        handles = Animator(A);
    end
    
    for i = floor(n/2):-1:1
        [A, handles] = heapify(A, n, i, handles);
    end

    for i = n:-1:1
        [A, handles] = swap(A, i, 1, handles);
        [A, handles] = heapify(A, i, 1, handles);
    end
end

function handles = Animator(A)
    figure('Color', 'w'); hold on;
    recx = [-0.5,-0.5,0.5,0.5]; recy = [0,1,1,0];
    lo = 1; hi = numel(A);
    handles = arrayfun(@(i)fill(recx+i, A(i)*recy, 'm'), lo:hi);
    axis tight; axis off; delay = 3;
    txt = text(mean(xlim), mean(ylim), num2str(delay), ...
        'FontSize', 200,'Interpreter','latex', ...
        'HorizontalAlignment', 'center');
    while(delay >= 0)
        if(delay>0)
            pause(1); 
        else
            pause(0.05);
        end
        delay = delay - 1;
        txt.String = num2str(delay);
    end
    txt.String = "";
end

function [A, handles] = heapify(A, n, i, handles)
    l = 2*i;
    r = 2*i+1;

    if(l < n && A(i) < A(l))
        largest = l;
    else
        largest = i;
    end

    if(r < n && A(largest) < A(r))
        largest = r;
    end

    if largest ~= i
        [A, handles] = swap(A, i, largest, handles);
        [A, handles] = heapify(A, n, largest, handles);
    end
end

function [A, handles] = swap(A, i, j, handles)
    A([i,j]) = A([j,i]); 
    if(~isempty(handles))
        handles(i).FaceColor = 'r';
        handles(j).FaceColor = 'g';
        recx = [-0.5,-0.5,0.5,0.5];
        ai = recx+double(i); bj = recx+double(j);
        for f = 0:0.2:1
            h = handles(i); h.XData = ai + f*(bj - ai);
            h = handles(j); h.XData = bj + f*(ai - bj);
            drawnow; 
        end
        handles([i, j]) = handles([j, i]);
        handles(i).FaceColor = 'b'; 
        handles(j).FaceColor = 'b';
    end
end
