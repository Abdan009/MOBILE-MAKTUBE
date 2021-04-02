part of 'visitors_cubit.dart';

@immutable
abstract class VisitorsState {}

class VisitorLoaded extends VisitorsState {
  final List<Visitor> listVisitor;
  VisitorLoaded(this.listVisitor);
}
