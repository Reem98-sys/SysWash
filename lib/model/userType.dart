
class UserType {
    int? uTypeId;
    String? userTypeName;
    bool? cusUser;
    bool? dashboard;
    bool? dashbEdit;
    bool? pos;
    bool? usermangement;
    bool? users;
    bool? isUserTypeEnabled;
    bool? master;
    bool? customer;
    bool? customerEdit;
    bool? customerDelete;
    bool? employee;
    bool? employeeEdit;
    bool? employeeDelete;
    bool? driver;
    bool? driverEdit;
    bool? driverDelete;
    bool? clothType;
    bool? clothTypeEdit;
    bool? clothTypeDelete;
    bool? services;
    bool? servicesEdit;
    bool? servicesDelete;
    bool? priceList;
    bool? priceListEdit;
    bool? priceListDelete;
    bool? acType;
    bool? acTypeEdit;
    bool? acTypeDelete;
    bool? plant;
    bool? plantEdit;
    bool? plantDelete;
    bool? order;
    bool? orderList;
    bool? orderEdit;
    bool? deleteOrder;
    bool? driverAssign;
    bool? orderAssign;
    bool? printLabel;
    bool? priority;
    bool? report;
    bool? orderReport;
    bool? salesReport;
    bool? cashLedgerReport;
    bool? expenseReport;
    bool? transactionReport;
    bool? readyforReport;
    bool? deptorsReport;
    bool? customerReport;
    bool? employeeReport;
    bool? driverReport;
    bool? editHistory;
    bool? itemWisReport;
    bool? closingReport;
    bool? deptorsAllReport;
    bool? serviceWiseReport;
    bool? expense;
    bool? expenseAdd;
    bool? expCategory;
    bool? dayBook;
    bool? settings;
    bool? company;
    bool? generalSettings;
    bool? updateDb;
    bool? dbBackup;
    bool? outdoorService;
    bool? outdoorlist;
    bool? outdoorPos;
    bool? changepassword;
    bool? payment;
    bool? salesInvoice;
    bool? shelf;
    bool? priceEdit;
    bool? walletAdd;
    bool? walletDelete;
    bool? customerWalletReport;
    bool? plantList;
    bool? plantNewEdit;
    bool? plantNewDelete;
    bool? plantWiseReport;
    bool? whatsAppShare;
    bool? voidPayment;
    bool? pickup;
    bool? support;
    bool? closingReportPos;
    bool? rack;
    bool? rackEdit;
    bool? rackDelete;
    bool? rackList;
    bool? rackListedit;
    bool? rackListdelete;
    bool? paymentdelete;
    bool? limits;
    bool? userWiseReport;
    bool? notification;
    bool? editAfterpayment;
    bool? orderReportfilter;
    bool? salesReportfilter;
    bool? cashLedgerReportfilter;
    bool? expenseReportfilter;
    bool? transactionReportfilter;
    bool? readyforReportfilter;
    bool? deptorsReportfilter;
    bool? customerReportfilter;
    bool? employeeReportfilter;
    bool? driverReportfilter;
    bool? editHistoryfilter;
    bool? itemWisReportfilter;
    bool? closingReportfilter;
    bool? deptorsAllReportfilter;
    bool? serviceWiseReportfilter;
    bool? userWiseReportfilter;
    bool? discount;
    bool? statusChange;
    bool? dbMapping;
    bool? addbranch;
    bool? orderreadyrpt;
    bool? branchclsrpt;
    bool? userdashboard;
    bool? trash;

    UserType({this.uTypeId, this.userTypeName, this.cusUser, this.dashboard, this.dashbEdit, this.pos, this.usermangement, this.users, this.isUserTypeEnabled, this.master, this.customer, this.customerEdit, this.customerDelete, this.employee, this.employeeEdit, this.employeeDelete, this.driver, this.driverEdit, this.driverDelete, this.clothType, this.clothTypeEdit, this.clothTypeDelete, this.services, this.servicesEdit, this.servicesDelete, this.priceList, this.priceListEdit, this.priceListDelete, this.acType, this.acTypeEdit, this.acTypeDelete, this.plant, this.plantEdit, this.plantDelete, this.order, this.orderList, this.orderEdit, this.deleteOrder, this.driverAssign, this.orderAssign, this.printLabel, this.priority, this.report, this.orderReport, this.salesReport, this.cashLedgerReport, this.expenseReport, this.transactionReport, this.readyforReport, this.deptorsReport, this.customerReport, this.employeeReport, this.driverReport, this.editHistory, this.itemWisReport, this.closingReport, this.deptorsAllReport, this.serviceWiseReport, this.expense, this.expenseAdd, this.expCategory, this.dayBook, this.settings, this.company, this.generalSettings, this.updateDb, this.dbBackup, this.outdoorService, this.outdoorlist, this.outdoorPos, this.changepassword, this.payment, this.salesInvoice, this.shelf, this.priceEdit, this.walletAdd, this.walletDelete, this.customerWalletReport, this.plantList, this.plantNewEdit, this.plantNewDelete, this.plantWiseReport, this.whatsAppShare, this.voidPayment, this.pickup, this.support, this.closingReportPos, this.rack, this.rackEdit, this.rackDelete, this.rackList, this.rackListedit, this.rackListdelete, this.paymentdelete, this.limits, this.userWiseReport, this.notification, this.editAfterpayment, this.orderReportfilter, this.salesReportfilter, this.cashLedgerReportfilter, this.expenseReportfilter, this.transactionReportfilter, this.readyforReportfilter, this.deptorsReportfilter, this.customerReportfilter, this.employeeReportfilter, this.driverReportfilter, this.editHistoryfilter, this.itemWisReportfilter, this.closingReportfilter, this.deptorsAllReportfilter, this.serviceWiseReportfilter, this.userWiseReportfilter, this.discount, this.statusChange, this.dbMapping, this.addbranch, this.orderreadyrpt, this.branchclsrpt, this.userdashboard, this.trash});

    UserType.fromJson(Map<String, dynamic> json) {
        if(json["uTypeId"] is num) {
            uTypeId = (json["uTypeId"] as num).toInt();
        }
        if(json["userType"] is String) {
            userTypeName  = json["userType"];
        }
        if(json["cusUser"] is bool) {
            cusUser = json["cusUser"];
        }
        if(json["dashboard"] is bool) {
            dashboard = json["dashboard"];
        }
        if(json["dashbEdit"] is bool) {
            dashbEdit = json["dashbEdit"];
        }
        if(json["pos"] is bool) {
            pos = json["pos"];
        }
        if(json["usermangement"] is bool) {
            usermangement = json["usermangement"];
        }
        if(json["users"] is bool) {
            users = json["users"];
        }
        if(json["user_type"] is bool) {
            isUserTypeEnabled = json["user_type"];
        }
        if(json["master"] is bool) {
            master = json["master"];
        }
        if(json["customer"] is bool) {
            customer = json["customer"];
        }
        if(json["customerEdit"] is bool) {
            customerEdit = json["customerEdit"];
        }
        if(json["customerDelete"] is bool) {
            customerDelete = json["customerDelete"];
        }
        if(json["employee"] is bool) {
            employee = json["employee"];
        }
        if(json["employeeEdit"] is bool) {
            employeeEdit = json["employeeEdit"];
        }
        if(json["employeeDelete"] is bool) {
            employeeDelete = json["employeeDelete"];
        }
        if(json["driver"] is bool) {
            driver = json["driver"];
        }
        if(json["driverEdit"] is bool) {
            driverEdit = json["driverEdit"];
        }
        if(json["driverDelete"] is bool) {
            driverDelete = json["driverDelete"];
        }
        if(json["clothType"] is bool) {
            clothType = json["clothType"];
        }
        if(json["clothTypeEdit"] is bool) {
            clothTypeEdit = json["clothTypeEdit"];
        }
        if(json["clothTypeDelete"] is bool) {
            clothTypeDelete = json["clothTypeDelete"];
        }
        if(json["services"] is bool) {
            services = json["services"];
        }
        if(json["servicesEdit"] is bool) {
            servicesEdit = json["servicesEdit"];
        }
        if(json["servicesDelete"] is bool) {
            servicesDelete = json["servicesDelete"];
        }
        if(json["priceList"] is bool) {
            priceList = json["priceList"];
        }
        if(json["priceListEdit"] is bool) {
            priceListEdit = json["priceListEdit"];
        }
        if(json["priceListDelete"] is bool) {
            priceListDelete = json["priceListDelete"];
        }
        if(json["acType"] is bool) {
            acType = json["acType"];
        }
        if(json["acTypeEdit"] is bool) {
            acTypeEdit = json["acTypeEdit"];
        }
        if(json["acTypeDelete"] is bool) {
            acTypeDelete = json["acTypeDelete"];
        }
        if(json["plant"] is bool) {
            plant = json["plant"];
        }
        if(json["plantEdit"] is bool) {
            plantEdit = json["plantEdit"];
        }
        if(json["plantDelete"] is bool) {
            plantDelete = json["plantDelete"];
        }
        if(json["order"] is bool) {
            order = json["order"];
        }
        if(json["orderList"] is bool) {
            orderList = json["orderList"];
        }
        if(json["orderEdit"] is bool) {
            orderEdit = json["orderEdit"];
        }
        if(json["deleteOrder"] is bool) {
            deleteOrder = json["deleteOrder"];
        }
        if(json["driverAssign"] is bool) {
            driverAssign = json["driverAssign"];
        }
        if(json["orderAssign"] is bool) {
            orderAssign = json["orderAssign"];
        }
        if(json["printLabel"] is bool) {
            printLabel = json["printLabel"];
        }
        if(json["priority"] is bool) {
            priority = json["priority"];
        }
        if(json["report"] is bool) {
            report = json["report"];
        }
        if(json["orderReport"] is bool) {
            orderReport = json["orderReport"];
        }
        if(json["salesReport"] is bool) {
            salesReport = json["salesReport"];
        }
        if(json["cashLedgerReport"] is bool) {
            cashLedgerReport = json["cashLedgerReport"];
        }
        if(json["expenseReport"] is bool) {
            expenseReport = json["expenseReport"];
        }
        if(json["transactionReport"] is bool) {
            transactionReport = json["transactionReport"];
        }
        if(json["readyforReport"] is bool) {
            readyforReport = json["readyforReport"];
        }
        if(json["deptorsReport"] is bool) {
            deptorsReport = json["deptorsReport"];
        }
        if(json["customerReport"] is bool) {
            customerReport = json["customerReport"];
        }
        if(json["employeeReport"] is bool) {
            employeeReport = json["employeeReport"];
        }
        if(json["driverReport"] is bool) {
            driverReport = json["driverReport"];
        }
        if(json["editHistory"] is bool) {
            editHistory = json["editHistory"];
        }
        if(json["itemWisReport"] is bool) {
            itemWisReport = json["itemWisReport"];
        }
        if(json["closingReport"] is bool) {
            closingReport = json["closingReport"];
        }
        if(json["deptorsAllReport"] is bool) {
            deptorsAllReport = json["deptorsAllReport"];
        }
        if(json["serviceWiseReport"] is bool) {
            serviceWiseReport = json["serviceWiseReport"];
        }
        if(json["expense"] is bool) {
            expense = json["expense"];
        }
        if(json["expenseAdd"] is bool) {
            expenseAdd = json["expenseAdd"];
        }
        if(json["expCategory"] is bool) {
            expCategory = json["expCategory"];
        }
        if(json["dayBook"] is bool) {
            dayBook = json["dayBook"];
        }
        if(json["settings"] is bool) {
            settings = json["settings"];
        }
        if(json["company"] is bool) {
            company = json["company"];
        }
        if(json["generalSettings"] is bool) {
            generalSettings = json["generalSettings"];
        }
        if(json["updateDb"] is bool) {
            updateDb = json["updateDb"];
        }
        if(json["dbBackup"] is bool) {
            dbBackup = json["dbBackup"];
        }
        if(json["outdoorService"] is bool) {
            outdoorService = json["outdoorService"];
        }
        if(json["outdoorlist"] is bool) {
            outdoorlist = json["outdoorlist"];
        }
        if(json["outdoorPos"] is bool) {
            outdoorPos = json["outdoorPos"];
        }
        if(json["changepassword"] is bool) {
            changepassword = json["changepassword"];
        }
        if(json["payment"] is bool) {
            payment = json["payment"];
        }
        if(json["salesInvoice"] is bool) {
            salesInvoice = json["salesInvoice"];
        }
        if(json["shelf"] is bool) {
            shelf = json["shelf"];
        }
        if(json["priceEdit"] is bool) {
            priceEdit = json["priceEdit"];
        }
        if(json["walletAdd"] is bool) {
            walletAdd = json["walletAdd"];
        }
        if(json["walletDelete"] is bool) {
            walletDelete = json["walletDelete"];
        }
        if(json["customerWalletReport"] is bool) {
            customerWalletReport = json["customerWalletReport"];
        }
        if(json["plantList"] is bool) {
            plantList = json["plantList"];
        }
        if(json["plantNewEdit"] is bool) {
            plantNewEdit = json["plantNewEdit"];
        }
        if(json["plantNewDelete"] is bool) {
            plantNewDelete = json["plantNewDelete"];
        }
        if(json["plantWiseReport"] is bool) {
            plantWiseReport = json["plantWiseReport"];
        }
        if(json["whatsAppShare"] is bool) {
            whatsAppShare = json["whatsAppShare"];
        }
        if(json["voidPayment"] is bool) {
            voidPayment = json["voidPayment"];
        }
        if(json["pickup"] is bool) {
            pickup = json["pickup"];
        }
        if(json["support"] is bool) {
            support = json["support"];
        }
        if(json["closingReportPos"] is bool) {
            closingReportPos = json["closingReportPos"];
        }
        if(json["rack"] is bool) {
            rack = json["rack"];
        }
        if(json["rackEdit"] is bool) {
            rackEdit = json["rackEdit"];
        }
        if(json["rackDelete"] is bool) {
            rackDelete = json["rackDelete"];
        }
        if(json["rackList"] is bool) {
            rackList = json["rackList"];
        }
        if(json["rackListedit"] is bool) {
            rackListedit = json["rackListedit"];
        }
        if(json["rackListdelete"] is bool) {
            rackListdelete = json["rackListdelete"];
        }
        if(json["paymentdelete"] is bool) {
            paymentdelete = json["paymentdelete"];
        }
        if(json["Limits"] is bool) {
            limits = json["Limits"];
        }
        if(json["userWiseReport"] is bool) {
            userWiseReport = json["userWiseReport"];
        }
        if(json["notification"] is bool) {
            notification = json["notification"];
        }
        if(json["editAfterpayment"] is bool) {
            editAfterpayment = json["editAfterpayment"];
        }
        if(json["orderReportfilter"] is bool) {
            orderReportfilter = json["orderReportfilter"];
        }
        if(json["salesReportfilter"] is bool) {
            salesReportfilter = json["salesReportfilter"];
        }
        if(json["cashLedgerReportfilter"] is bool) {
            cashLedgerReportfilter = json["cashLedgerReportfilter"];
        }
        if(json["expenseReportfilter"] is bool) {
            expenseReportfilter = json["expenseReportfilter"];
        }
        if(json["transactionReportfilter"] is bool) {
            transactionReportfilter = json["transactionReportfilter"];
        }
        if(json["readyforReportfilter"] is bool) {
            readyforReportfilter = json["readyforReportfilter"];
        }
        if(json["deptorsReportfilter"] is bool) {
            deptorsReportfilter = json["deptorsReportfilter"];
        }
        if(json["customerReportfilter"] is bool) {
            customerReportfilter = json["customerReportfilter"];
        }
        if(json["employeeReportfilter"] is bool) {
            employeeReportfilter = json["employeeReportfilter"];
        }
        if(json["driverReportfilter"] is bool) {
            driverReportfilter = json["driverReportfilter"];
        }
        if(json["editHistoryfilter"] is bool) {
            editHistoryfilter = json["editHistoryfilter"];
        }
        if(json["itemWisReportfilter"] is bool) {
            itemWisReportfilter = json["itemWisReportfilter"];
        }
        if(json["closingReportfilter"] is bool) {
            closingReportfilter = json["closingReportfilter"];
        }
        if(json["deptorsAllReportfilter"] is bool) {
            deptorsAllReportfilter = json["deptorsAllReportfilter"];
        }
        if(json["serviceWiseReportfilter"] is bool) {
            serviceWiseReportfilter = json["serviceWiseReportfilter"];
        }
        if(json["userWiseReportfilter"] is bool) {
            userWiseReportfilter = json["userWiseReportfilter"];
        }
        if(json["discount"] is bool) {
            discount = json["discount"];
        }
        if(json["statusChange"] is bool) {
            statusChange = json["statusChange"];
        }
        if(json["dbMapping"] is bool) {
            dbMapping = json["dbMapping"];
        }
        if(json["addbranch"] is bool) {
            addbranch = json["addbranch"];
        }
        if(json["orderreadyrpt"] is bool) {
            orderreadyrpt = json["orderreadyrpt"];
        }
        if(json["branchclsrpt"] is bool) {
            branchclsrpt = json["branchclsrpt"];
        }
        if(json["userdashboard"] is bool) {
            userdashboard = json["userdashboard"];
        }
        if(json["trash"] is bool) {
            trash = json["trash"];
        }
    }

    static List<UserType> fromList(List<Map<String, dynamic>> list) {
        return list.map(UserType.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["uTypeId"] = uTypeId;
        _data["userType"] = userTypeName;
        _data["cusUser"] = cusUser;
        _data["dashboard"] = dashboard;
        _data["dashbEdit"] = dashbEdit;
        _data["pos"] = pos;
        _data["usermangement"] = usermangement;
        _data["users"] = users;
        _data["user_type"] = isUserTypeEnabled;
        _data["master"] = master;
        _data["customer"] = customer;
        _data["customerEdit"] = customerEdit;
        _data["customerDelete"] = customerDelete;
        _data["employee"] = employee;
        _data["employeeEdit"] = employeeEdit;
        _data["employeeDelete"] = employeeDelete;
        _data["driver"] = driver;
        _data["driverEdit"] = driverEdit;
        _data["driverDelete"] = driverDelete;
        _data["clothType"] = clothType;
        _data["clothTypeEdit"] = clothTypeEdit;
        _data["clothTypeDelete"] = clothTypeDelete;
        _data["services"] = services;
        _data["servicesEdit"] = servicesEdit;
        _data["servicesDelete"] = servicesDelete;
        _data["priceList"] = priceList;
        _data["priceListEdit"] = priceListEdit;
        _data["priceListDelete"] = priceListDelete;
        _data["acType"] = acType;
        _data["acTypeEdit"] = acTypeEdit;
        _data["acTypeDelete"] = acTypeDelete;
        _data["plant"] = plant;
        _data["plantEdit"] = plantEdit;
        _data["plantDelete"] = plantDelete;
        _data["order"] = order;
        _data["orderList"] = orderList;
        _data["orderEdit"] = orderEdit;
        _data["deleteOrder"] = deleteOrder;
        _data["driverAssign"] = driverAssign;
        _data["orderAssign"] = orderAssign;
        _data["printLabel"] = printLabel;
        _data["priority"] = priority;
        _data["report"] = report;
        _data["orderReport"] = orderReport;
        _data["salesReport"] = salesReport;
        _data["cashLedgerReport"] = cashLedgerReport;
        _data["expenseReport"] = expenseReport;
        _data["transactionReport"] = transactionReport;
        _data["readyforReport"] = readyforReport;
        _data["deptorsReport"] = deptorsReport;
        _data["customerReport"] = customerReport;
        _data["employeeReport"] = employeeReport;
        _data["driverReport"] = driverReport;
        _data["editHistory"] = editHistory;
        _data["itemWisReport"] = itemWisReport;
        _data["closingReport"] = closingReport;
        _data["deptorsAllReport"] = deptorsAllReport;
        _data["serviceWiseReport"] = serviceWiseReport;
        _data["expense"] = expense;
        _data["expenseAdd"] = expenseAdd;
        _data["expCategory"] = expCategory;
        _data["dayBook"] = dayBook;
        _data["settings"] = settings;
        _data["company"] = company;
        _data["generalSettings"] = generalSettings;
        _data["updateDb"] = updateDb;
        _data["dbBackup"] = dbBackup;
        _data["outdoorService"] = outdoorService;
        _data["outdoorlist"] = outdoorlist;
        _data["outdoorPos"] = outdoorPos;
        _data["changepassword"] = changepassword;
        _data["payment"] = payment;
        _data["salesInvoice"] = salesInvoice;
        _data["shelf"] = shelf;
        _data["priceEdit"] = priceEdit;
        _data["walletAdd"] = walletAdd;
        _data["walletDelete"] = walletDelete;
        _data["customerWalletReport"] = customerWalletReport;
        _data["plantList"] = plantList;
        _data["plantNewEdit"] = plantNewEdit;
        _data["plantNewDelete"] = plantNewDelete;
        _data["plantWiseReport"] = plantWiseReport;
        _data["whatsAppShare"] = whatsAppShare;
        _data["voidPayment"] = voidPayment;
        _data["pickup"] = pickup;
        _data["support"] = support;
        _data["closingReportPos"] = closingReportPos;
        _data["rack"] = rack;
        _data["rackEdit"] = rackEdit;
        _data["rackDelete"] = rackDelete;
        _data["rackList"] = rackList;
        _data["rackListedit"] = rackListedit;
        _data["rackListdelete"] = rackListdelete;
        _data["paymentdelete"] = paymentdelete;
        _data["Limits"] = limits;
        _data["userWiseReport"] = userWiseReport;
        _data["notification"] = notification;
        _data["editAfterpayment"] = editAfterpayment;
        _data["orderReportfilter"] = orderReportfilter;
        _data["salesReportfilter"] = salesReportfilter;
        _data["cashLedgerReportfilter"] = cashLedgerReportfilter;
        _data["expenseReportfilter"] = expenseReportfilter;
        _data["transactionReportfilter"] = transactionReportfilter;
        _data["readyforReportfilter"] = readyforReportfilter;
        _data["deptorsReportfilter"] = deptorsReportfilter;
        _data["customerReportfilter"] = customerReportfilter;
        _data["employeeReportfilter"] = employeeReportfilter;
        _data["driverReportfilter"] = driverReportfilter;
        _data["editHistoryfilter"] = editHistoryfilter;
        _data["itemWisReportfilter"] = itemWisReportfilter;
        _data["closingReportfilter"] = closingReportfilter;
        _data["deptorsAllReportfilter"] = deptorsAllReportfilter;
        _data["serviceWiseReportfilter"] = serviceWiseReportfilter;
        _data["userWiseReportfilter"] = userWiseReportfilter;
        _data["discount"] = discount;
        _data["statusChange"] = statusChange;
        _data["dbMapping"] = dbMapping;
        _data["addbranch"] = addbranch;
        _data["orderreadyrpt"] = orderreadyrpt;
        _data["branchclsrpt"] = branchclsrpt;
        _data["userdashboard"] = userdashboard;
        _data["trash"] = trash;
        return _data;
    }

    UserType copyWith({
        int? uTypeId,
        String? userTypeName,
        bool? cusUser,
        bool? dashboard,
        bool? dashbEdit,
        bool? pos,
        bool? usermangement,
        bool? users,
        bool? isUserTypeEnabled,
        bool? master,
        bool? customer,
        bool? customerEdit,
        bool? customerDelete,
        bool? employee,
        bool? employeeEdit,
        bool? employeeDelete,
        bool? driver,
        bool? driverEdit,
        bool? driverDelete,
        bool? clothType,
        bool? clothTypeEdit,
        bool? clothTypeDelete,
        bool? services,
        bool? servicesEdit,
        bool? servicesDelete,
        bool? priceList,
        bool? priceListEdit,
        bool? priceListDelete,
        bool? acType,
        bool? acTypeEdit,
        bool? acTypeDelete,
        bool? plant,
        bool? plantEdit,
        bool? plantDelete,
        bool? order,
        bool? orderList,
        bool? orderEdit,
        bool? deleteOrder,
        bool? driverAssign,
        bool? orderAssign,
        bool? printLabel,
        bool? priority,
        bool? report,
        bool? orderReport,
        bool? salesReport,
        bool? cashLedgerReport,
        bool? expenseReport,
        bool? transactionReport,
        bool? readyforReport,
        bool? deptorsReport,
        bool? customerReport,
        bool? employeeReport,
        bool? driverReport,
        bool? editHistory,
        bool? itemWisReport,
        bool? closingReport,
        bool? deptorsAllReport,
        bool? serviceWiseReport,
        bool? expense,
        bool? expenseAdd,
        bool? expCategory,
        bool? dayBook,
        bool? settings,
        bool? company,
        bool? generalSettings,
        bool? updateDb,
        bool? dbBackup,
        bool? outdoorService,
        bool? outdoorlist,
        bool? outdoorPos,
        bool? changepassword,
        bool? payment,
        bool? salesInvoice,
        bool? shelf,
        bool? priceEdit,
        bool? walletAdd,
        bool? walletDelete,
        bool? customerWalletReport,
        bool? plantList,
        bool? plantNewEdit,
        bool? plantNewDelete,
        bool? plantWiseReport,
        bool? whatsAppShare,
        bool? voidPayment,
        bool? pickup,
        bool? support,
        bool? closingReportPos,
        bool? rack,
        bool? rackEdit,
        bool? rackDelete,
        bool? rackList,
        bool? rackListedit,
        bool? rackListdelete,
        bool? paymentdelete,
        bool? limits,
        bool? userWiseReport,
        bool? notification,
        bool? editAfterpayment,
        bool? orderReportfilter,
        bool? salesReportfilter,
        bool? cashLedgerReportfilter,
        bool? expenseReportfilter,
        bool? transactionReportfilter,
        bool? readyforReportfilter,
        bool? deptorsReportfilter,
        bool? customerReportfilter,
        bool? employeeReportfilter,
        bool? driverReportfilter,
        bool? editHistoryfilter,
        bool? itemWisReportfilter,
        bool? closingReportfilter,
        bool? deptorsAllReportfilter,
        bool? serviceWiseReportfilter,
        bool? userWiseReportfilter,
        bool? discount,
        bool? statusChange,
        bool? dbMapping,
        bool? addbranch,
        bool? orderreadyrpt,
        bool? branchclsrpt,
        bool? userdashboard,
        bool? trash,
    }) => UserType(
        uTypeId: uTypeId ?? this.uTypeId,
        userTypeName: userTypeName ?? this.userTypeName,
        cusUser: cusUser ?? this.cusUser,
        dashboard: dashboard ?? this.dashboard,
        dashbEdit: dashbEdit ?? this.dashbEdit,
        pos: pos ?? this.pos,
        usermangement: usermangement ?? this.usermangement,
        users: users ?? this.users,
        isUserTypeEnabled: isUserTypeEnabled ?? this.isUserTypeEnabled,
        master: master ?? this.master,
        customer: customer ?? this.customer,
        customerEdit: customerEdit ?? this.customerEdit,
        customerDelete: customerDelete ?? this.customerDelete,
        employee: employee ?? this.employee,
        employeeEdit: employeeEdit ?? this.employeeEdit,
        employeeDelete: employeeDelete ?? this.employeeDelete,
        driver: driver ?? this.driver,
        driverEdit: driverEdit ?? this.driverEdit,
        driverDelete: driverDelete ?? this.driverDelete,
        clothType: clothType ?? this.clothType,
        clothTypeEdit: clothTypeEdit ?? this.clothTypeEdit,
        clothTypeDelete: clothTypeDelete ?? this.clothTypeDelete,
        services: services ?? this.services,
        servicesEdit: servicesEdit ?? this.servicesEdit,
        servicesDelete: servicesDelete ?? this.servicesDelete,
        priceList: priceList ?? this.priceList,
        priceListEdit: priceListEdit ?? this.priceListEdit,
        priceListDelete: priceListDelete ?? this.priceListDelete,
        acType: acType ?? this.acType,
        acTypeEdit: acTypeEdit ?? this.acTypeEdit,
        acTypeDelete: acTypeDelete ?? this.acTypeDelete,
        plant: plant ?? this.plant,
        plantEdit: plantEdit ?? this.plantEdit,
        plantDelete: plantDelete ?? this.plantDelete,
        order: order ?? this.order,
        orderList: orderList ?? this.orderList,
        orderEdit: orderEdit ?? this.orderEdit,
        deleteOrder: deleteOrder ?? this.deleteOrder,
        driverAssign: driverAssign ?? this.driverAssign,
        orderAssign: orderAssign ?? this.orderAssign,
        printLabel: printLabel ?? this.printLabel,
        priority: priority ?? this.priority,
        report: report ?? this.report,
        orderReport: orderReport ?? this.orderReport,
        salesReport: salesReport ?? this.salesReport,
        cashLedgerReport: cashLedgerReport ?? this.cashLedgerReport,
        expenseReport: expenseReport ?? this.expenseReport,
        transactionReport: transactionReport ?? this.transactionReport,
        readyforReport: readyforReport ?? this.readyforReport,
        deptorsReport: deptorsReport ?? this.deptorsReport,
        customerReport: customerReport ?? this.customerReport,
        employeeReport: employeeReport ?? this.employeeReport,
        driverReport: driverReport ?? this.driverReport,
        editHistory: editHistory ?? this.editHistory,
        itemWisReport: itemWisReport ?? this.itemWisReport,
        closingReport: closingReport ?? this.closingReport,
        deptorsAllReport: deptorsAllReport ?? this.deptorsAllReport,
        serviceWiseReport: serviceWiseReport ?? this.serviceWiseReport,
        expense: expense ?? this.expense,
        expenseAdd: expenseAdd ?? this.expenseAdd,
        expCategory: expCategory ?? this.expCategory,
        dayBook: dayBook ?? this.dayBook,
        settings: settings ?? this.settings,
        company: company ?? this.company,
        generalSettings: generalSettings ?? this.generalSettings,
        updateDb: updateDb ?? this.updateDb,
        dbBackup: dbBackup ?? this.dbBackup,
        outdoorService: outdoorService ?? this.outdoorService,
        outdoorlist: outdoorlist ?? this.outdoorlist,
        outdoorPos: outdoorPos ?? this.outdoorPos,
        changepassword: changepassword ?? this.changepassword,
        payment: payment ?? this.payment,
        salesInvoice: salesInvoice ?? this.salesInvoice,
        shelf: shelf ?? this.shelf,
        priceEdit: priceEdit ?? this.priceEdit,
        walletAdd: walletAdd ?? this.walletAdd,
        walletDelete: walletDelete ?? this.walletDelete,
        customerWalletReport: customerWalletReport ?? this.customerWalletReport,
        plantList: plantList ?? this.plantList,
        plantNewEdit: plantNewEdit ?? this.plantNewEdit,
        plantNewDelete: plantNewDelete ?? this.plantNewDelete,
        plantWiseReport: plantWiseReport ?? this.plantWiseReport,
        whatsAppShare: whatsAppShare ?? this.whatsAppShare,
        voidPayment: voidPayment ?? this.voidPayment,
        pickup: pickup ?? this.pickup,
        support: support ?? this.support,
        closingReportPos: closingReportPos ?? this.closingReportPos,
        rack: rack ?? this.rack,
        rackEdit: rackEdit ?? this.rackEdit,
        rackDelete: rackDelete ?? this.rackDelete,
        rackList: rackList ?? this.rackList,
        rackListedit: rackListedit ?? this.rackListedit,
        rackListdelete: rackListdelete ?? this.rackListdelete,
        paymentdelete: paymentdelete ?? this.paymentdelete,
        limits: limits ?? this.limits,
        userWiseReport: userWiseReport ?? this.userWiseReport,
        notification: notification ?? this.notification,
        editAfterpayment: editAfterpayment ?? this.editAfterpayment,
        orderReportfilter: orderReportfilter ?? this.orderReportfilter,
        salesReportfilter: salesReportfilter ?? this.salesReportfilter,
        cashLedgerReportfilter: cashLedgerReportfilter ?? this.cashLedgerReportfilter,
        expenseReportfilter: expenseReportfilter ?? this.expenseReportfilter,
        transactionReportfilter: transactionReportfilter ?? this.transactionReportfilter,
        readyforReportfilter: readyforReportfilter ?? this.readyforReportfilter,
        deptorsReportfilter: deptorsReportfilter ?? this.deptorsReportfilter,
        customerReportfilter: customerReportfilter ?? this.customerReportfilter,
        employeeReportfilter: employeeReportfilter ?? this.employeeReportfilter,
        driverReportfilter: driverReportfilter ?? this.driverReportfilter,
        editHistoryfilter: editHistoryfilter ?? this.editHistoryfilter,
        itemWisReportfilter: itemWisReportfilter ?? this.itemWisReportfilter,
        closingReportfilter: closingReportfilter ?? this.closingReportfilter,
        deptorsAllReportfilter: deptorsAllReportfilter ?? this.deptorsAllReportfilter,
        serviceWiseReportfilter: serviceWiseReportfilter ?? this.serviceWiseReportfilter,
        userWiseReportfilter: userWiseReportfilter ?? this.userWiseReportfilter,
        discount: discount ?? this.discount,
        statusChange: statusChange ?? this.statusChange,
        dbMapping: dbMapping ?? this.dbMapping,
        addbranch: addbranch ?? this.addbranch,
        orderreadyrpt: orderreadyrpt ?? this.orderreadyrpt,
        branchclsrpt: branchclsrpt ?? this.branchclsrpt,
        userdashboard: userdashboard ?? this.userdashboard,
        trash: trash ?? this.trash,
    );
    bool hasPermission(String key) {
  final Map<String, bool?> permissionMap = {
    "orderReport": orderReport,
    "salesReport": salesReport,
    "cashLedgerReport": cashLedgerReport,
    "expenseReport": expenseReport,
    "transactionReport": transactionReport,
    "deptorsReport": deptorsReport,
    "customerReport": customerReport,
    "employeeReport": employeeReport,
    "driverReport": driverReport,
    "itemWisReport": itemWisReport,
    "closingReport": closingReport,
    "plantWiseReport": plantWiseReport,
    "editHistory": editHistory,
    "serviceWiseReport": serviceWiseReport,
  };

  return permissionMap[key] == true;
}
}