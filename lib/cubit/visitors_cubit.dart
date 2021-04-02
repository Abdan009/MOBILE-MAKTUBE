import 'package:bloc/bloc.dart';
import 'package:maktube/model/models.dart';
import 'package:maktube/services/services.dart';
import 'package:meta/meta.dart';

part 'visitors_state.dart';

class VisitorsCubit extends Cubit<VisitorsState> {
  VisitorsCubit() : super(VisitorLoaded(null));

  Future<void> getVisitorInVideo(String idVideo) async {
    List<Visitor> listVisitor = await VisitorService().getVisitors(idVideo);
    emit(VisitorLoaded(listVisitor));
  }

  Future<void> addVisitorInVideo(Visitor visitor) async {
    await VisitorService().addVisitor(visitor);
    List<Visitor> listVisitor;
    if ((state as VisitorLoaded).listVisitor != null) {
      listVisitor = (state as VisitorLoaded).listVisitor + [visitor];
    } else {
      listVisitor = [visitor];
    }
    emit(VisitorLoaded(listVisitor));
  }
}
