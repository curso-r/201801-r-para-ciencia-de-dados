calculate_roc <- function(df, cost_of_fp = 1, cost_of_fn = 1, n = 100) {
  tpr <- function(df, threshold) {
    sum(df$pred >= threshold & df$Survived == 1) / sum(df$Survived == 1)
  }
  
  fpr <- function(df, threshold) {
    sum(df$pred >= threshold & df$Survived == 0) / sum(df$Survived == 0)
  }
  
  cost <- function(df, threshold, cost_of_fp, cost_of_fn) {
    sum(df$pred >= threshold & df$Survived == 0) * cost_of_fp + 
      sum(df$pred < threshold & df$Survived == 1) * cost_of_fn
  }
  
  roc <- data.frame(threshold = seq(0, 1, length.out = n), tpr = NA, fpr = NA)
  roc$tpr <- sapply(roc$threshold, function(th) tpr(df, th))
  roc$fpr <- sapply(roc$threshold, function(th) fpr(df, th))
  roc$cost <- sapply(roc$threshold, function(th) cost(df, th, cost_of_fp, cost_of_fn))
  
  return(roc)
}

plot_roc <- function(roc, threshold, cost_of_fp = 1, cost_of_fn = 1) {
  
  norm_vec <- function(v) (v - min(v))/diff(range(v))
  
  idx_threshold = which.min(abs(roc$threshold-threshold))
  
  col_ramp <- colorRampPalette(c("green","orange","red","black"))(100)
  col_by_cost <- col_ramp[ceiling(norm_vec(roc$cost)*99)+1]
  
  ggplot(roc, aes(fpr,tpr)) + 
    geom_line(color=rgb(0,0,1,alpha=0.3)) +
    geom_point(color=col_by_cost, size=4, alpha=0.5) +
    coord_fixed() +
    geom_line(aes(threshold,threshold), color=rgb(0,0,1,alpha=0.5)) +
    xlab("1 - especificidade") + 
    ylab("Sensibilidade") +
    geom_hline(yintercept=roc[idx_threshold,"tpr"], alpha=0.5, linetype="dashed") +
    geom_vline(xintercept=roc[idx_threshold,"fpr"], alpha=0.5, linetype="dashed") +
    theme_bw()
  
  
}
