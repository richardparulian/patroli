class CheckOutRouteArgs {
  final String? reportId;
  final String? branchId; 
  final String? branchName;

  const CheckOutRouteArgs({
    required this.reportId,
    required this.branchId,
    required this.branchName,
  });
}