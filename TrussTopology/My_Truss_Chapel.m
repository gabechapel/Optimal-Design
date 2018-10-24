%% Optimal Design Project 1
clear all; close all;

%% Initial Conditions
truss = [11,20]; % size of truss
N = truss(1)*truss(2); % number of nodes
m = nchoosek(N,2); % number of beams
area = 1; % surface area
Sy = 8; % yield strength
F = 4; % External force

% Positions using convention [1 2 3 4
%                             5 6 7 8 ....
Floc = 120; % position of the force 
anchLoc = [81,101,121]; % position of anchors

% Truss grid
figure
hold on
plot([19 19],[5 3],'r','Linewidth',2)
plot([19 18.5],[3 3.5],'r','Linewidth',2)
plot([19 19.5],[3 3.5],'r','Linewidth',2)
plot([0 -1 -1 0],[6 5.7 6.5 6],'k','Linewidth',2)
plot([0 -1 -1 0],[5 4.7 5.5 5],'k','Linewidth',2)
plot([0 -1 -1 0],[4 3.7 4.5 4],'k','Linewidth',2)
plot([-1.5 -1],[3.5 3.8],'k','Linewidth',2)
plot([-1.5 -1],[3.8 4.1],'k','Linewidth',2)
plot([-1.5 -1],[4.1 4.4],'k','Linewidth',2)
plot([-1.5 -1],[4.5 4.8],'k','Linewidth',2)
plot([-1.5 -1],[4.8 5.1],'k','Linewidth',2)
plot([-1.5 -1],[5.1 5.4],'k','Linewidth',2)
plot([-1.5 -1],[5.5 5.8],'k','Linewidth',2)
plot([-1.5 -1],[5.8 6.1],'k','Linewidth',2)
plot([-1.5 -1],[6.1 6.4],'k','Linewidth',2)
for i = 1:truss(2)
    for j = 1:truss(1)
        plot(i-1,j-1, 'k.')
    end
end
text(19.5, 4, 'F', 'interpreter', 'Latex', 'FontSize', 15, 'Color', 'k')
xlabel ('X(m)','interpreter','Latex')
ylabel ('Y(m)','interpreter','Latex')
set(gca,'FontSize',15)
set(gca,'FontName','cmr12')
axis equal

% Numbering convention example (2x3)
figure
hold on
for i = 1:3
    for j = 1:2
        plot(i-1, j-1, 'k.', 'MarkerSize', 25)
    end
end
plot([0 2], [1 1], 'r', 'Linewidth', 6)
plot([0 1], [1 1], 'b', 'Linewidth', 3)
plot([0 0], [1 0], 'g', 'Linewidth', 3)
plot([0 1], [1 0], 'm', 'Linewidth', 3)
plot([0 2], [1 0], 'c', 'Linewidth', 3)
plot([1 2], [1 1], 'c', 'Linewidth', 3)
plot([1 0], [1 0], 'b', 'Linewidth', 3)
plot([1 1], [1 0], 'r', 'Linewidth', 3)
plot([1 2], [1 0], 'g', 'Linewidth', 3)
xlabel ('X(m)','interpreter','Latex')
ylabel ('Y(m)','interpreter','Latex')
set(gca,'FontSize',15)
set(gca,'FontName','cmr12')
axis equal
xlim([-1 3])
ylim([-1 2])

% Node labels
text(-.55, 1, 'Node 1', 'interpreter', 'Latex', 'FontSize', 15, 'Color', 'k')
text(.75, 1.35, 'Node 2', 'interpreter', 'Latex', 'FontSize', 15, 'Color', 'k')
text(2.05, 1, 'Node 3', 'interpreter', 'Latex', 'FontSize', 15, 'Color', 'k')
text(-.55, 0, 'Node 4', 'interpreter', 'Latex', 'FontSize', 15, 'Color', 'k')
text(.75, -.25, 'Node 5', 'interpreter', 'Latex', 'FontSize', 15, 'Color', 'k')
text(2.05, 0, 'Node 6', 'interpreter', 'Latex', 'FontSize', 15, 'Color', 'k')
% Link labels
text(.35, 1.07, 'Link 1', 'interpreter', 'Latex', 'FontSize', 12, 'Color', 'b')
text(.85, 1.15, 'Link 2', 'interpreter', 'Latex', 'FontSize', 12, 'Color', 'r')
plot([0 .85], [1.15 1.15], 'r', 'Linewidth', 1)
plot([1.18 2], [1.15 1.15], 'r', 'Linewidth', 1)
plot([0 0], [1.1 1.2], 'r', 'Linewidth', 1)
plot([2 2], [1.1 1.2], 'r', 'Linewidth', 1)
text(-.4, .5, 'Link 3', 'interpreter', 'Latex', 'FontSize', 12, 'Color', 'g')
text(.6, 0, 'Link 4', 'interpreter', 'Latex', 'FontSize', 12, 'Color', 'm')
text(1.55, 0, 'Link 5', 'interpreter', 'Latex', 'FontSize', 12, 'Color', 'c')
text(1.35, 1.07, 'Link 6', 'interpreter', 'Latex', 'FontSize', 12, 'Color', 'c')
text(0.1, 0, 'Link 7', 'interpreter', 'Latex', 'FontSize', 12, 'Color', 'b')
text(1.1, 0, 'Link 8', 'interpreter', 'Latex', 'FontSize', 12, 'Color', 'r')
text(1.75, .5, 'Link 9', 'interpreter', 'Latex', 'FontSize', 12, 'Color', 'g')

%% Static Equilibrium
% Make a list of points
k = 1;
for i = 1:truss(1)
    for j = 1:truss(2)
        pointList(k,:) = [j-1,-(i-1)]; % switch i and j to make list [x,y]
        k = k+1;
    end
end

% Make a list of angles for Aeq and a list of lengths for plotting
k = 1;
mhat = [];
plotLen = [];
for i = 1:truss(1)
    for j = 1:truss(2)
        beamLen = pointList(k+1:end,:) - pointList(k,:);
        mhat = [mhat; beamLen./vecnorm(beamLen')'];
        k = k+1;
        plotLen = [plotLen; beamLen];
    end
end

% Set up equality constraint that the sum of the forces equals zero
Aeq = zeros(2*N, m);
ind2 = 0; % index 1
ind1 = 1; % index 2
inc2 = 1; % increment by 2
inc1 = 1; % increment by 1
for i = 1:N-1
    ind2 = ind2+(N-1)-(i-1);
    Aeq(inc2:inc2+1,ind1:ind2) = mhat(ind1:ind2,:)'; % Current node to other nodes
    for j = 2*i+1:2:2*N           % Other nodes to current node
        Aeq(j,inc1) = -mhat(inc1,1);
        Aeq(j+1,inc1) = -mhat(inc1,2);
        inc1 = inc1+1;
    end
    ind1 = ind1+(N-1)-(i-1);
    inc2 = inc2+2;
end
beq = zeros(N*2,1);

%% Minimize ||u||_1 ==> |u|<t
Aineq = [speye(m) -speye(m);
        -speye(m) -speye(m)];
bineq = [zeros(m,1); zeros(m,1)];

%% Develop LP
% Account for t in eq system
Aeq = [Aeq zeros(2*N,m)];

% External Forces
Aeq = [Aeq zeros(N*2,1)]; % Add external force to static equations
Aeq(2*Floc,end) = -1;
Aeq = [Aeq; zeros(1,m*2+1)]; % Specify value of external force
Aeq(end,end) = 1; 
beq = [beq; F];

Aineq = [Aineq zeros(m*2,1)]; % account for force variable in inequality

% Remove anchors from static equation
Aeq([anchLoc(1)*2-1:anchLoc(1)*2, anchLoc(2)*2-1:anchLoc(2)*2,...
    anchLoc(3)*2-1:anchLoc(3)*2],:) = [];
beq([anchLoc(1)*2-1:anchLoc(1)*2, anchLoc(2)*2-1:anchLoc(2)*2,...
    anchLoc(3)*2-1:anchLoc(3)*2]) = [];


% Cost function
c = [zeros(1,m) ones(1,m) 0]';

% Solve the LP with yield strength upper and lower bounds (dual simplex)
x = linprog(c, Aineq, bineq, Aeq, beq,-area*Sy*ones(m,1), area*Sy*ones(m,1));
u = x(1:m); % pull out forces
beamCount = find(u); % find nonzero forces

% Plot grid
figure
hold on
plot([19 19],[5 3],'r','Linewidth',2)
plot([19 18.5],[3 3.5],'r','Linewidth',2)
plot([19 19.5],[3 3.5],'r','Linewidth',2)
plot([0 -1 -1 0],[6 5.7 6.5 6],'k','Linewidth',2)
plot([0 -1 -1 0],[5 4.7 5.5 5],'k','Linewidth',2)
plot([0 -1 -1 0],[4 3.7 4.5 4],'k','Linewidth',2)
plot([-1.5 -1],[3.5 3.8],'k','Linewidth',2)
plot([-1.5 -1],[3.8 4.1],'k','Linewidth',2)
plot([-1.5 -1],[4.1 4.4],'k','Linewidth',2)
plot([-1.5 -1],[4.5 4.8],'k','Linewidth',2)
plot([-1.5 -1],[4.8 5.1],'k','Linewidth',2)
plot([-1.5 -1],[5.1 5.4],'k','Linewidth',2)
plot([-1.5 -1],[5.5 5.8],'k','Linewidth',2)
plot([-1.5 -1],[5.8 6.1],'k','Linewidth',2)
plot([-1.5 -1],[6.1 6.4],'k','Linewidth',2)
for i = 1:truss(2)
    for j = 1:truss(1)
        plot(i-1,j-1, 'k.')
    end
end
text(19.5, 4, 'F', 'interpreter', 'Latex', 'FontSize', 15, 'Color', 'k')
xlabel ('X(m)','interpreter','Latex')
ylabel ('Y(m)','interpreter','Latex')
set(gca,'FontSize',15)
set(gca,'FontName','cmr12')
axis equal

%% Length Weighting
c_weight = [zeros(1,m) vecnorm(plotLen') 0]'; % weight the problem with lengths
x_weight = linprog(c_weight, Aineq, bineq, Aeq, beq,-area*Sy*ones(m,1),...
    area*Sy*ones(m,1));

u_weight = x_weight(1:m);
% Set any forces less than the error to zero
for error = [0.0000001, 0.000001, 0.00001]
    beamCount_weight = find(u_weight);
    k = 1;
    for i = beamCount_weight'
        if abs(u_weight(i)) < error
            beamCount_weight(k) = [];
        else
            k = k+1;
        end
    end

    % Plot grid
    figure
    hold on
    plot([19 19],[5 3],'r','Linewidth',2)
    plot([19 18.5],[3 3.5],'r','Linewidth',2)
    plot([19 19.5],[3 3.5],'r','Linewidth',2)
    plot([0 -1 -1 0],[6 5.7 6.5 6],'k','Linewidth',2)
    plot([0 -1 -1 0],[5 4.7 5.5 5],'k','Linewidth',2)
    plot([0 -1 -1 0],[4 3.7 4.5 4],'k','Linewidth',2)
    plot([-1.5 -1],[3.5 3.8],'k','Linewidth',2)
    plot([-1.5 -1],[3.8 4.1],'k','Linewidth',2)
    plot([-1.5 -1],[4.1 4.4],'k','Linewidth',2)
    plot([-1.5 -1],[4.5 4.8],'k','Linewidth',2)
    plot([-1.5 -1],[4.8 5.1],'k','Linewidth',2)
    plot([-1.5 -1],[5.1 5.4],'k','Linewidth',2)
    plot([-1.5 -1],[5.5 5.8],'k','Linewidth',2)
    plot([-1.5 -1],[5.8 6.1],'k','Linewidth',2)
    plot([-1.5 -1],[6.1 6.4],'k','Linewidth',2)
    axis equal
    text(19.5, 4, 'F', 'interpreter', 'Latex', 'FontSize', 15, 'Color', 'k')
    xlabel ('X(m)','interpreter','Latex')
    ylabel ('Y(m)','interpreter','Latex')
    set(gca,'FontSize',15)
    set(gca,'FontName','cmr12')
    % Plot truss
    k = 1;
    ind = 1;
    for i = 1:N-1
        if ind > length(beamCount_weight)
                break
        end
        k = k+(N-1)-(i-1);
        while beamCount_weight(ind) < k
            % Change linewidth depending on magnitude of force
            if abs(u_weight(beamCount_weight(ind))) < 3
                linewidth = 1;
            elseif abs(u_weight(beamCount_weight(ind))) < 6
                linewidth = 3;
            else
                linewidth = 5;
            end
            % Change color depending on direction of force
            if u_weight(beamCount_weight(ind)) > 0 % Tension
                plot([pointList(i,1),pointList(i,1)+...
                    plotLen(beamCount_weight(ind),1)], [pointList(i,2)+...
                    10,pointList(i,2)+plotLen(beamCount_weight(ind),2)+10],...
                    'b', 'LineWidth', linewidth);
            else % Compression
                plot([pointList(i,1),pointList(i,1)+...
                    plotLen(beamCount_weight(ind),1)],[pointList(i,2)+...
                    10,pointList(i,2)+plotLen(beamCount_weight(ind),2)+10],...
                    'r', 'LineWidth', linewidth);
            end 
            ind = ind+1;
            if ind > length(beamCount_weight)
                break
            end
        end
    end
end
maxLen = max(plotLen(beamCount_weight)); % Maximum member length in weighted case

% % Plot truss
% k = 1;
% ind = 1;
% for i = 1:N-1
%     if ind > length(beamCount)
%             break
%     end
%     k = k+(N-1)-(i-1);
%     while beamCount(ind) < k
%         % Change linewidth depending on magnitude of force
%             if abs(u_weight(beamCount_weight(ind))) < 3
%                 linewidth = 1;
%             elseif abs(u_weight(beamCount_weight(ind))) < 6
%                 linewidth = 3;
%             else
%                 linewidth = 5;
%             end
%         if u(beamCount(ind)) > 0 % Tension
%             plot([pointList(i,1),pointList(i,1)+plotLen(beamCount(ind),1)],...
%                 [pointList(i,2)+10,pointList(i,2)+plotLen(beamCount(ind),2)+10],...
%                 'b', 'Linewidth', linewidth);
%         else % Compression
%             plot([pointList(i,1),pointList(i,1)+plotLen(beamCount(ind),1)],...
%                 [pointList(i,2)+10,pointList(i,2)+plotLen(beamCount(ind),2)+10],...
%                 'r', 'Linewidth', linewidth);
%         end
%         ind = ind+1;
%         if ind > length(beamCount)
%             break
%         end
%     end
% end