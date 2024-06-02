class Notifications {
  final String? schoolAvt;
  final String? schoolName;
  final String? notiTitle;
  final String? notiContent;
  final String? time;

  Notifications({
    this.schoolAvt,
    this.schoolName,
    this.notiTitle,
    this.notiContent,
    this.time,
  });

  static List<Notifications> getSampleData() {
    return [
      Notifications(
        schoolAvt: 'https://images.pexels.com/photos/1366630/pexels-photo-1366630.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        schoolName: 'Huflit America',
        notiTitle: 'Thông báo mới nè vô xem thoai !!!',
        notiContent: 'Content 1',
        time: '5 minutes ago',
      ),
      Notifications(
        schoolAvt: 'https://images.pexels.com/photos/1366630/pexels-photo-1366630.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        schoolName: 'Huflit America',
        notiTitle: 'Thông báo mới nè vô xem thoai !!!',
        notiContent: 'Content 2',
        time: '10 minutes ago',
      ),
      Notifications(
        schoolAvt: 'https://images.pexels.com/photos/1366630/pexels-photo-1366630.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        schoolName: 'Huflit America',
        notiTitle: 'Thông báo mới nè vô xem thoai !!!',
        notiContent: 'Content 3',
        time: '15 minutes ago',
      ),
      Notifications(
        schoolAvt: 'https://images.pexels.com/photos/1366630/pexels-photo-1366630.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        schoolName: 'Huflit America',
        notiTitle: 'Thông báo mới nè vô xem thoai !!!',
        notiContent: 'Content 3',
        time: '15 minutes ago',
      ),
      Notifications(
        schoolAvt: 'https://images.pexels.com/photos/1366630/pexels-photo-1366630.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        schoolName: 'Huflit America',
        notiTitle: 'Thông báo mới nè vô xem thoai !!!',
        notiContent: 'Content 3',
        time: '15 minutes ago',
      ),
      Notifications(
        schoolAvt: 'https://images.pexels.com/photos/1366630/pexels-photo-1366630.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        schoolName: 'Huflit America',
        notiTitle: 'Thông báo mới nè vô xem thoai !!!',
        notiContent: 'Content 3',
        time: '15 minutes ago',
      ),
      Notifications(
        schoolAvt: 'https://images.pexels.com/photos/1366630/pexels-photo-1366630.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        schoolName: 'Huflit America',
        notiTitle: 'Thông báo mới nè vô xem thoai !!!',
        notiContent: 'Content 3',
        time: '15 minutes ago',
      ),
    ];
  }
}