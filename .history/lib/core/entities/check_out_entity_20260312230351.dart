class CheckOutRouteArgs {
  final int? reportId;
  final int? branchId; 
  final String? branchName;

  const CheckOutRouteArgs({
    required this.reportId,
    required this.branchId,
    required this.branchName,
  });
}