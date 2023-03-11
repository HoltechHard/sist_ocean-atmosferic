function sol = rungkutta_metheorology(a, b, y1_ini, y2_ini, y3_ini, n)

    % functions 
    
    % dy1/dt = f1(y1, y2, y3)
    f1 = inline("(dQ-lam*(y1-y2)-la*y1)/ca", "y1", "y2", "y3", "dQ", "ca", "cm", "cd", "la", "lam", "lmd");
    % dy2/dt = f2(y1, y2, y3)
    f2 = inline("(-lam*(y2-y1)-lmd*(y2-y3))/cm", "y1", "y2", "y3", "dQ", "ca", "cm", "cd", "la", "lam", "lmd");
    % dy3/dt = f3(y1, y2, y3)
    f3 = inline("(-lmd*(y3-y2))/cd", "y1", "y2", "y3", "dQ", "ca", "cm", "cd", "la", "lam", "lmd");
    
    % data struct for string of functions
    sf.f{1} = f1;
    sf.f{2} = f2;
    sf.f{3} = f3;
    
    % definition of constants
    dQ = 1;
    ca = 0.45;  cm = 10;    cd = 100;
    la = 2.4;   lam = 45;   lmd = 2;
    
    % step
    h = (b-a)/n;
    % initialize vector time T
    T = zeros(1, n+1);
    % initialize vector Y1, Y2, Y3
    Y = zeros(3, n+1);
    % split interval [a, b] using step h
    T = a:h:b;
    % define the initial conditions 
    Y(1, 1) = y1_ini;
    Y(2, 1) = y2_ini;
    Y(3, 1) = y3_ini;
    
    syms y1 y2 y3
    
    % cycle for n iterations
    for j=1:n
        % recover variables y1, y2, y3
        y1 = Y(1, j);
        y2 = Y(2, j);
        y3 = Y(3, j);    
    
        % calculate k1, k2, k3, k4 for each variable Y
        % compute k1
        for i=1:3
            k1(i) = feval(sf.f{i}, y1, y2, y3, dQ, ca, cm, cd, la, lam, lmd);
        end
    
        % compute k2    
        for i=1:3
            a(i) = h/2 * k1(i);        
        end
        
        for i=1:3
            k2(i) = feval(sf.f{i}, y1 + a(1), y2 + a(2), y3 + a(3), dQ, ca, cm, cd, la, lam, lmd);
        end
    
        % compute k3
        for i=1:3
            b(i) = h/2 * k2(i);
        end
    
        for i=1:3
            k3(i) = feval(sf.f{i}, y1 + b(1), y2 + b(2), y3 + b(3), dQ, ca, cm, cd, la, lam, lmd);
        end
    
        % compute k4
        for i=1:3
            c(i) = h * k3(i);
        end
    
        for i=1:3
            k4(i) = feval(sf.f{i}, y1 + c(1), y2 + c(2), y3 + c(3), dQ, ca, cm, cd, la, lam, lmd);
        end
    
        % update values for Y
        for i=1:3
            Y(i, j+1) = Y(i, j) + h/6 * (k1(i) + 2*k2(i) + 2*k3(i) + k4(i));
        end
    
    end    
    
    % solution
    
    sol = [T' Y'];
    
    % finish algorithm!
    
    % execution
    % format long
    % sol = rungkutta_metheorology(0, 1, 0, 0, 0, 365)
    
    % configurations for input function
    % a = 0
    % b = 1
    % y1_ini = y2_ini = y3_ini = 0
    % n = 365

    