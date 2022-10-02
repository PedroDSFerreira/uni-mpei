function probability = coin_toss_probability(p, n, k, N)
    rand_throws = rand(n,N) > p;
    success = sum(rand_throws) == k;
    probability = sum(success)/N;
end
