class Urls {
  static const String baseUrl = "https://417sptdw-8001.inc1.devtunnels.ms";
  static const String serviceUrl = "$baseUrl/service";

  static const String registerUrl = "$serviceUrl/service_register/";
  static const String loginUrl = "$serviceUrl/login/";
  static const String getEmployeesDetailsListUrl =
      "$serviceUrl/view_all_employees/";
  static const String getEmployeesCountUrl = "$serviceUrl/employee_count/";
  static const String getPresentEmployeesListUrl =
      "$serviceUrl/view_present_employees/";
  static const String addEmployeeUrl = "$serviceUrl/add_employee/";
  static const String addProductUrl = "$serviceUrl/add_product/";
  static const String updateProductUrl = "$serviceUrl/update_product/";
  static const String getProductsUrl = "$serviceUrl/view_products/";
  static const String getProductDetailsUrl = "$serviceUrl/view_single_product/";
  static const String getPurchaseHistoryUrl =
      "$serviceUrl/view_purchased_products/";
  static const String getRepairRequestListUrl =
      "$serviceUrl/view_repair_requests/";
  static const String getRepairRequestItemUrl =
      "$serviceUrl/view_single_repair/";
  static const String getEmployeesListUrl = "$serviceUrl/view_employees/";
  static const String assignEmployeeUrl = "$serviceUrl/assign_employee/";
  static const String getServiceCentreProfileDetailsUrl =
      "$serviceUrl/service_centre_view_profile/";
  static const String getFeedbackListUrl = "$serviceUrl/view_feedback/";
  static const String getEmployeeAttendanceRecordUrl =
      "$serviceUrl/attendance_record/";
  static const String approveLeaveUrl = "$serviceUrl/approve_leave/";
  static const String rejectLeaveUrl = "$serviceUrl/reject_leave/";

  static const String getEmployeeWorksUrl =
      "$serviceUrl/employee_view_assigned_repairs/";
  static const String completeRepairUrl = "$serviceUrl/employee_update_status/";
  static const String getEmplyeeProfileDetailsUrl =
      "$serviceUrl/employee_view_profile/";
  static const String submitAttendanceUrl = "$serviceUrl/employee_attendance/";
  static const String getEmployeeAttendanceStatusUrl =
      "$serviceUrl/check_attendance/";
}
