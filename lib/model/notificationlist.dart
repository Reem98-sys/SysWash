
class NotificationList {
    int? notificationId;
    int? driverId;
    String? title;
    String? body;
    String? notificationType;
    String? referenceId;
    int? customerId;
    bool? isRead;
    String? createdAt;
    bool? trash;

    NotificationList({this.notificationId, this.driverId, this.title, this.body, this.notificationType, this.referenceId, this.customerId, this.isRead, this.createdAt, this.trash});

    NotificationList.fromJson(Map<String, dynamic> json) {
        if(json["notificationId"] is num) {
            notificationId = (json["notificationId"] as num).toInt();
        }
        if(json["driverId"] is num) {
            driverId = (json["driverId"] as num).toInt();
        }
        if(json["title"] is String) {
            title = json["title"];
        }
        if(json["body"] is String) {
            body = json["body"];
        }
        if(json["notificationType"] is String) {
            notificationType = json["notificationType"];
        }
        if(json["referenceId"] is String) {
            referenceId = json["referenceId"];
        }
        if(json["customerId"] is num) {
            customerId = (json["customerId"] as num).toInt();
        }
        if(json["isRead"] is bool) {
            isRead = json["isRead"];
        }
        if(json["createdAt"] is String) {
            createdAt = json["createdAt"];
        }
        if(json["trash"] is bool) {
            trash = json["trash"];
        }
    }

    static List<NotificationList> fromList(List<Map<String, dynamic>> list) {
        return list.map(NotificationList.fromJson).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["notificationId"] = notificationId;
        _data["driverId"] = driverId;
        _data["title"] = title;
        _data["body"] = body;
        _data["notificationType"] = notificationType;
        _data["referenceId"] = referenceId;
        _data["customerId"] = customerId;
        _data["isRead"] = isRead;
        _data["createdAt"] = createdAt;
        _data["trash"] = trash;
        return _data;
    }

    NotificationList copyWith({
        int? notificationId,
        int? driverId,
        String? title,
        String? body,
        String? notificationType,
        String? referenceId,
        int? customerId,
        bool? isRead,
        String? createdAt,
        bool? trash,
    }) => NotificationList(
        notificationId: notificationId ?? this.notificationId,
        driverId: driverId ?? this.driverId,
        title: title ?? this.title,
        body: body ?? this.body,
        notificationType: notificationType ?? this.notificationType,
        referenceId: referenceId ?? this.referenceId,
        customerId: customerId ?? this.customerId,
        isRead: isRead ?? this.isRead,
        createdAt: createdAt ?? this.createdAt,
        trash: trash ?? this.trash,
    );
}