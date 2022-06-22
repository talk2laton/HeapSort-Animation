function A = HeapSort(A, delay)
    close all; handles = []; 
    figure('Color', 'w'); hold on;
    recx = [-0.5,-0.5,0.5,0.5]; recy = [0,1,1,0];
    lo = 1; hi = numel(A);
    for i = lo:hi
        h = fill(recx+i, A(i)*recy, 'm');
        handles = [handles, h];
    end
    axis tight; axis off;
    if(delay>0)
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
    
    for i = lo:hi
        j = i; parent = int8(max(1, floor(j/2)));
        while(A(j) > A(parent))
            [A, handles] = swap(A, j, parent, handles);
            j = parent; parent = int8(floor(j/2));
        end
    end

    for k = hi:-1:1
        j = 1; 
        [A, handles] = swap(A, j, k, handles);
        leftchild = 2; rightchild = 3;
        left = A(leftchild); right = A(rightchild);
        while(A(j) < max(left, right) && rightchild < k)
            if(left > right)
                [A, handles] = swap(A, j, leftchild, handles); 
                j = leftchild; 
            else
                [A, handles] = swap(A, j, rightchild, handles); 
                j = rightchild;
            end
            leftchild = 2 * j; rightchild = 2 * j + 1;
            disp([left, right])
            left = A(j); 
            right = A(j);
            if(leftchild < k) 
                left = A(leftchild);
            end
            if(rightchild < k) 
                right = A(rightchild);
            end
            disp([left, right])
            disp("==================================")
        end
    end
end

function [A, handles] = swap(A, i, j, handles)
    handles(i).FaceColor = 'r';
    handles(j).FaceColor = 'g';
    recx = [-0.5,-0.5,0.5,0.5];
    temp = A(i); A(i) = A(j); A(j) = temp;
    ai = recx+(i*1.0); bj = recx+(j*1.0);
    for f = 0:0.02:1
        h = handles(i); h.XData = ai + f*(bj - ai);
        h = handles(j); h.XData = bj + f*(ai - bj);
        drawnow; 
    end
    temp = handles(i); handles(i) = handles(j); handles(j) = temp;
    handles(i).FaceColor = 'b'; handles(j).FaceColor = 'b';
end