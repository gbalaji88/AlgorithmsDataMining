close all; clear all; clc;

%% Load data sample and prepare
load fisheriris;
%X = meas;
%S = species;
[X,S] = shuffle_dataset(meas, species);

[Si, Sl]=grp2idx(S); % Change class name into ordinal index

[X_train X_test] = splitting_dataset(X,1);
[S_train S_test] = splitting_dataset(Si,1);

S_test = S_train;

K = 3;

%% Run
tic();
    [idx,C,sumd,D] = kmeans(X_train,K);
etime = toc();

%% Validation
bad_predicted = find(S_test~=idx);
error_rate = length(bad_predicted)/size(X_test,1);

%% Print outputs
fprintf('Finished\n');
fprintf('Elapsed time is %0.5f seconds.\n', etime);
fprintf('Error rate is %0.5f.\n', error_rate);


%% Plot
figure(1)
subplot(1,2,1) % first subplot
gscatter(meas(:,1), meas(:,2), species,'rgb','osd');
hold on;
grid on;
plot(X(bad_predicted,1),X(bad_predicted,2),'kx');
xlabel('Sepal length');
ylabel('Sepal width');
title 'Fisher''s Iris Data';
subplot(1,2,2) % second subplot
gscatter(meas(:,3), meas(:,4), species,'rgb','osd');
hold on;
grid on;
plot(X(bad_predicted,3),X(bad_predicted,4),'kx');
xlabel('Petal length');
ylabel('Petal width');
title 'Fisher''s Iris Data';