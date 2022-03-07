class PC {
  String prefName;
  String name;
  String target;
  String mac;
  int port;
  int type; //1 = ip, 2 = dns

  PC(
      {this.prefName = "",
      required this.name,
      required this.target,
      required this.mac,
      required this.port,
      required this.type});

  Map<String, dynamic> toJson() => {
        //'prefName': prefName,
        'name': name,
        'target': target,
        'mac': mac,
        'port': port,
        'type': type,
      };
  static PC fromJson(Map<String, dynamic> json, String prefName) => PC(
        prefName: prefName,
        name: json['name'],
        target: json['target'] ?? json['ip'],
        mac: json['mac'],
        port: json['port'],
        type: json['type'] ?? 1,
      );
}
